pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import qs.services.niri

Singleton {
    id: root

    readonly property list<var> items: {
        const running = [...ToplevelManager.toplevels.values];
        const pinned = Config.launcher.pinned_apps || [];
        const resultList = [];

        const normalizeId = id => {
            if (!id)
                return "";
            return id.toLowerCase().replace(/\.desktop$/, "").trim();
        };

        const resolveAppMetadata = (appId, title) => {
            let icon = "application-x-executable";
            let command = appId;
            let name = appId;
            let lookupId = appId;

            if (title === "Genshin Impact") {
                appId = "anime-game-launcher";
            }

            icon = AppSearch.guessIcon(appId);

            let entry = DesktopEntries.byId(appId) || DesktopEntries.heuristicLookup(appId);

            if (!entry && icon !== "application-x-executable" && icon !== "image-missing") {
                entry = DesktopEntries.byId(icon) || DesktopEntries.heuristicLookup(icon);
            }

            if (entry) {
                lookupId = entry.id;
                if (entry.command && entry.command.length > 0) {
                    command = entry.command.join(" ");
                }
                if (entry.name) {
                    name = entry.name;
                }
            } else {
                const reverseDomain = AppSearch.getReverseDomainNameAppName(appId);
                name = reverseDomain.charAt(0).toUpperCase() + reverseDomain.slice(1);
            }

            return {
                lookupId,
                icon,
                command,
                name
            };
        };

        const processedRunning = running.map(w => {
            const meta = resolveAppMetadata(w.appId, w.title || "");
            return {
                appId: w.appId,
                lookupId: meta.lookupId,
                name: meta.name,
                icon: meta.icon,
                command: meta.command,
                isRunning: true,
                isPinned: false,
                window: w
            };
        });

        const runningIdentifiers = new Set();
        processedRunning.forEach(w => {
            if (w.appId)
                runningIdentifiers.add(normalizeId(w.appId));
            if (w.lookupId)
                runningIdentifiers.add(normalizeId(w.lookupId));
            if (w.icon)
                runningIdentifiers.add(normalizeId(w.icon));
        });

        const normalizedPinned = pinned.map(p => normalizeId(p));
        processedRunning.forEach(w => {
            w.isPinned = normalizedPinned.includes(normalizeId(w.appId)) || normalizedPinned.includes(normalizeId(w.lookupId)) || normalizedPinned.includes(normalizeId(w.icon));
        });

        const sortedRunning = processedRunning.sort((a, b) => {
            if (a.window.workspaceId !== b.window.workspaceId) {
                return a.window.workspaceId - b.window.workspaceId;
            }
            return a.window.scrollingColumnIndex - b.window.scrollingColumnIndex;
        });

        sortedRunning.forEach(item => resultList.push(item));

        pinned.forEach(pin => {
            const pinMeta = resolveAppMetadata(pin, "");
            const normalizedPin = normalizeId(pin);
            const normalizedLookup = normalizeId(pinMeta.lookupId);
            const normalizedIcon = normalizeId(pinMeta.icon);

            const isAlreadyRunning = runningIdentifiers.has(normalizedPin) || runningIdentifiers.has(normalizedLookup) || runningIdentifiers.has(normalizedIcon);

            if (!isAlreadyRunning) {
                resultList.push({
                    appId: pin,
                    name: pinMeta.name,
                    icon: pinMeta.icon,
                    command: pinMeta.command,
                    isRunning: false,
                    isPinned: true,
                    window: null
                });
            }
        });

        return resultList;
    }
}
