pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import qs.services
import qs.services.niri

Singleton {
    id: root

    property bool isHyprland: false
    property bool isNiri: false
    property bool isMango: false
    property bool isSway: false
    property bool isScroll: false
    property bool isMiracle: false
    property bool isLabwc: false
    property string compositor: "unknown"
    property bool compositorDetected: false

    readonly property string hyprlandSignature: Quickshell.env("HYPRLAND_INSTANCE_SIGNATURE")
    readonly property string niriSocket: Quickshell.env("NIRI_SOCKET")
    readonly property string swaySocket: Quickshell.env("SWAYSOCK")
    property bool useNiriSorting: isNiri && NiriService

    signal toplevelsChanged

    Timer {
        id: compositorInitTimer
        interval: 100
        running: true
        repeat: false
        onTriggered: {
            detectCompositor();
            compositorDetected = true;
            Qt.callLater(() => {
            // NiriService.generateNiriLayoutConfig();
            // HyprlandService.generateLayoutConfig();
            // MangoService.generateLayoutConfig();
            });
        }
    }

    // Primary detection asks the kernel which process owns the $WAYLAND_DISPLAY
    // socket — the compositor quickshell is actually connected to. Env vars like
    // HYPRLAND_INSTANCE_SIGNATURE / MANGO_INSTANCE_SIGNATURE can leak into the
    // systemd user environment from previous sessions and lie. Unset
    // WAYLAND_DISPLAY falls back to "wayland-0", mirroring wl_display_connect.
    // /proc/net/unix: field 6 is state (01 = listening), 7 inode, 8 bound path.
    // The BSDs have no /proc/net; sockstat(1) -l -u lists listening unix
    // sockets as USER COMMAND PID FD PROTO LOCAL-ADDRESS.
    function detectCompositor() {
        const procScript = 'sock="${WAYLAND_DISPLAY:-wayland-0}"; case "$sock" in /*) ;; *) sock="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/$sock" ;; esac; inode=$(awk -v p="$sock" \'$8 == p && $6 == 1 {print $7; exit}\' /proc/net/unix); [ -n "$inode" ] || exit 1; fd=$(find /proc/[0-9]*/fd/ -mindepth 1 -maxdepth 1 -lname "socket:\\[$inode\\]" 2>/dev/null | head -n1); [ -n "$fd" ] || exit 1; pid="${fd#/proc/}"; cat "/proc/${pid%%/*}/comm"';
        const sockstatScript = 'sock="${WAYLAND_DISPLAY:-wayland-0}"; case "$sock" in /*) ;; *) sock="${XDG_RUNTIME_DIR:-/var/run/user/$(id -u)}/$sock" ;; esac; sockstat -l -u | awk -v p="$sock" \'$6 == p {print $2; exit}\'';
        const script = Qt.platform.os === "unix" ? sockstatScript : procScript;
        Proc.runCommand("waylandSocketOwner", ["sh", "-c", script], (output, exitCode) => {
            const comm = (exitCode === 0 && output) ? output.trim().toLowerCase() : "";
            const name = _compositorNameFromComm(comm);
            if (name) {
                _applyCompositor(name);
                log.info("Detected", name, "from Wayland socket owner:", comm);
                return;
            }
            if (comm)
                log.info("Unrecognized Wayland socket owner:", comm, "- falling back to env detection");
            _detectFromEnv(0);
        }, 0, 3000);
    }

    function _detectFromEnv(index) {
        const candidates = _envDetectionCandidates();
        for (let i = index; i < candidates.length; i++) {
            const c = candidates[i];
            if (!c.present)
                continue;
            const next = i + 1;
            Proc.runCommand(c.name + "SocketCheck", c.test, (output, exitCode) => {
                if (exitCode !== 0) {
                    console.warn(c.detail, "is set but not alive, skipping");
                    _detectFromEnv(next);
                    return;
                }
                const name = c.resolve ? c.resolve() : c.name;
                _applyCompositor(name);
                console.info("Detected", name, "via", c.detail);
            }, 0);
            return;
        }
        _applyCompositor("unknown");
        log.warn("No compositor detected");
    }

    // Fallback when the socket owner can't be resolved (no ss, unrecognized
    // comm). Same priority order as before, but every candidate must prove
    // liveness; a dead socket/PID falls through to the next candidate instead
    // of winning on a stale env var.
    function _envDetectionCandidates() {
        const runtimeDir = Quickshell.env("XDG_RUNTIME_DIR") || "";
        return [
            {
                name: "niri",
                present: !!niriSocket,
                test: ["test", "-S", niriSocket],
                detail: "NIRI_SOCKET " + niriSocket
            },
            {
                name: "sway",
                present: !!swaySocket,
                test: ["test", "-S", swaySocket],
                resolve: () => {
                    const desktop = String(Quickshell.env("XDG_CURRENT_DESKTOP") || "").toLowerCase();
                    return desktop.includes("sway") ? "sway" : "scroll";
                },
                detail: "SWAYSOCK " + swaySocket
            },
            {
                name: "hyprland",
                present: !!hyprlandSignature,
                test: ["test", "-S", runtimeDir + "/hypr/" + hyprlandSignature + "/.socket.sock"],
                detail: "HYPRLAND_INSTANCE_SIGNATURE " + hyprlandSignature
            }
        ];
    }

    function _compositorNameFromComm(comm) {
        switch (comm) {
        case "niri":
            return "niri";
        case "hyprland":
            return "hyprland";
        case "sway":
            return "sway";
        case "scroll":
            return "scroll";
        case "mango":
            return "mango";
        case "miracle-wm":
            return "miracle";
        case "labwc":
            return "labwc";
        default:
            return "";
        }
    }

    function _applyCompositor(name) {
        isHyprland = name === "hyprland";
        isNiri = name === "niri";
        isMango = name === "mango";
        isSway = name === "sway";
        isScroll = name === "scroll";
        isMiracle = name === "miracle";
        isLabwc = name === "labwc";
        compositor = name;
        compositorDetected = true;
        if (isNiri)
            NiriService.generateNiriBlurrule();
    }
}
