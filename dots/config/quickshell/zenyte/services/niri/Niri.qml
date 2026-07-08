pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property alias available: niriSocket.connected
    readonly property alias path: niriSocket.path
    property list<NiriWorkspace> workspaces: []
    property list<NiriWindow> windows: []

    property list<NiriKeyboardLayout> keyboardLayouts: []

    property bool isOverview: false
    property bool configLoaded: false

    property list<NiriCast> casts

    property NiriWindow focusedWindow: null
    property NiriWorkspace focusedWorkspace: null
    property ShellScreen focusedScreen: Quickshell.screens.find(s => s.name === focusedWorkspace?.output) ?? null

    signal screenshot(path: string)

    function updateFocusedWindow() {
        root.focusedWindow = root.windows.find(w => w.isFocused) ?? null;
    }

    function updateFocusedWorkspace() {
        root.focusedWorkspace = root.workspaces.find(ws => ws.isFocused) ?? null;
    }

    Socket {
        id: niriSocket
        path: Quickshell.env("NIRI_SOCKET")
        connected: true

        onConnectionStateChanged: {
            if (!connected)
                return;

            write("\"EventStream\"\n");
        }

        parser: SplitParser {
            onRead: data => {
                let json = JSON.parse(data);
                let event = getEvent(json);
                json = json[event];

                switch (event) {
                case "WorkspacesChanged":
                    workspacesChanged(json);
                    break;
                case "WorkspaceUrgencyChanged":
                    workspaceUrgencyChanged(json);
                    break;
                case "WorkspaceActivated":
                    workspaceActivated(json);
                    break;
                case "WorkspaceActiveWindowChanged":
                    workspaceActiveWindowChanged(json);
                    break;
                case "WindowsChanged":
                    windowsChanged(json);
                    break;
                case "WindowOpenedOrChanged":
                    windowOpenedOrChanged(json);
                    break;
                case "WindowClosed":
                    windowClosed(json);
                    break;
                case "WindowFocusChanged":
                    windowFocusChanged(json);
                    break;
                case "WindowFocusTimestampChanged":
                    windowFocusTimestampChanged(json);
                    break;
                case "WindowUrgencyChanged":
                    windowUrgencyChanged(json);
                    break;
                case "WindowLayoutsChanged":
                    windowLayoutsChanged(json);
                    break;
                case "KeyboardLayoutsChanged":
                    keyboardLayoutsChanged(json);
                    break;
                case "KeyboardLayoutSwitched":
                    keyboardLayoutSwitched(json);
                    break;
                case "OverviewOpenedOrClosed":
                    overviewOpenedOrClosed(json);
                    break;
                case "ConfigLoaded":
                    configLoaded(json);
                    break;
                case "ScreenshotCaptured":
                    screenshotCaptured(json);
                    break;
                case "CastsChanged":
                    castChanged(json);
                    break;
                case "CastStartedOrChanged":
                    castStartedOrChanged(json);
                    break;
                case "CastStopped":
                    castStopped(json);
                    break;
                }
            }

            function getEvent(json: var): string {
                return Object.keys(json)[0];
            }

            function workspacesChanged(json: var) {
                const oldList = root.workspaces;
                const newList = json.workspaces;

                const oldMap = new Map(oldList.map(item => [item.id, item]));
                const newMap = new Map(newList.map(item => [item.id, item]));

                for (const [id, item] of newMap) {
                    if (!oldMap.has(id)) {
                        root.workspaces.push(root.createWorkspace(item));
                    } else {
                        const index = root.workspaces.findIndex(ws => ws.id === id);
                        if (index !== -1) {
                            let ws = root.workspaces[index];
                            ws.idx = item.idx;
                            ws.name = item.name;
                            ws.output = item.output;
                            ws.isUrgent = item.is_urgent;
                            ws.isActive = item.is_active;
                            ws.isFocused = item.is_focused;
                            ws.activeWindowId = item.active_window_id ?? -1;
                            root.workspaces[index] = ws;
                        }
                    }
                }

                for (const [id] of oldMap) {
                    if (!newMap.has(id)) {
                        const index = root.workspaces.findIndex(ws => ws.id === id);
                        if (index !== -1) {
                            const old = root.workspaces[index];
                            root.workspaces.splice(index, 1);
                            if (root.focusedWorkspace !== null && root.focusedWorkspace.id === old.id) {
                                root.focusedWorkspace = null;
                            }
                            old.destroy();
                        }
                    }
                }

                root.updateFocusedWorkspace();
            }

            function workspaceUrgencyChanged(json: var) {
                const index = root.workspaces.findIndex(item => item.id === json.id);
                if (index !== -1) {
                    let workspace = root.workspaces[index];
                    workspace.isUrgent = json.urgent;
                    root.workspaces[index] = workspace;
                }
            }

            function workspaceActivated(json: var) {
                const activeIndex = root.workspaces.findIndex(item => item.id === json.id);
                if (activeIndex !== -1) {
                    let activeWorkspace = root.workspaces[activeIndex];
                    const sameOutputIds = root.workspaces.filter(item => item.output === activeWorkspace.output).map(item => item.id);

                    for (const id of sameOutputIds) {
                        const idx = root.workspaces.findIndex(item => item.id === id);
                        if (idx !== -1) {
                            let ws = root.workspaces[idx];
                            ws.isActive = false;
                            root.workspaces[idx] = ws;
                        }
                    }

                    if (json.focused) {
                        const oldFocusedIndex = root.workspaces.findIndex(item => item.isFocused);
                        if (oldFocusedIndex !== -1) {
                            let oldFocused = root.workspaces[oldFocusedIndex];
                            oldFocused.isFocused = false;
                            root.workspaces[oldFocusedIndex] = oldFocused;
                        }
                        activeWorkspace.isFocused = true;
                        root.focusedWorkspace = activeWorkspace;
                    }

                    activeWorkspace.isActive = true;
                    root.workspaces[activeIndex] = activeWorkspace;
                }
            }

            function workspaceActiveWindowChanged(json: var) {
                const index = root.workspaces.findIndex(item => item.id === json.workspace_id);
                if (index !== -1) {
                    let workspace = root.workspaces[index];
                    workspace.activeWindowId = json.active_window_id ?? -1;
                    root.workspaces[index] = workspace;
                }
            }

            function windowsChanged(json: var) {
                const oldList = root.windows;
                const newList = json.windows;

                const oldMap = new Map(oldList.map(item => [item.id, item]));
                const newMap = new Map(newList.map(item => [item.id, item]));

                for (const [id, item] of newMap) {
                    if (!oldMap.has(id)) {
                        root.windows.push(root.createWindow(item));
                    } else {
                        const index = root.windows.findIndex(win => win.id === id);
                        if (index !== -1) {
                            let win = root.windows[index];
                            win.title = item.title;
                            win.appId = item.app_id;
                            win.pid = item.pid;
                            win.workspaceId = item.workspace_id ?? -1;
                            win.isFocused = item.is_focused;
                            win.isFloating = item.is_floating;
                            win.isUrgent = item.is_urgent;
                            win.scrollingColumnIndex = item.layout.pos_in_scrolling_layout?.[0] ?? -1;
                            win.scrollingColumnTileIndex = item.layout.pos_in_scrolling_layout?.[1] ?? -1;
                            win.tileWidth = item.layout.tile_size?.[0] ?? -1;
                            win.tileHeight = item.layout.tile_size?.[1] ?? -1;
                            win.windowWidth = item.layout.window_size[0];
                            win.windowHeight = item.layout.window_size[1];
                            win.windowOffsetInTileX = item.layout.window_offset_in_tile[0];
                            win.windowOffsetInTileY = item.layout.window_offset_in_tile[1];
                            win.focusTimeStampSeconds = item.focus_timestamp.secs;
                            win.focusTimeStampNanos = item.focus_timestamp.nanos;
                            root.windows[index] = win;
                            if (root.focusedWindow !== null && root.focusedWindow.id === win.id) {
                                root.focusedWindow = win;
                            }
                        }
                    }
                }

                for (const [id] of oldMap) {
                    if (!newMap.has(id)) {
                        const index = root.windows.findIndex(win => win.id === id);
                        if (index !== -1) {
                            const old = root.windows[index];
                            root.windows.splice(index, 1);
                            if (root.focusedWindow !== null && root.focusedWindow.id === old.id) {
                                root.focusedWindow = null;
                            }
                            old.destroy();
                        }
                    }
                }

                root.updateFocusedWindow();
            }

            function windowOpenedOrChanged(json: var) {
                const foundIndex = root.windows.findIndex(item => item.id === json.window.id);

                if (foundIndex === -1) {
                    const window = root.createWindow(json.window);
                    root.windows.push(window);
                    if (window.isFocused) {
                        const oldFocusedIndex = root.windows.findIndex((item, i) => item.isFocused && i !== root.windows.length - 1);
                        if (oldFocusedIndex !== -1) {
                            root.windows[oldFocusedIndex].isFocused = false;
                            root.windows[oldFocusedIndex] = root.windows[oldFocusedIndex];
                        }
                        root.focusedWindow = window;
                    }
                } else {
                    let win = root.windows[foundIndex];
                    const item = json.window;
                    win.title = item.title;
                    win.appId = item.app_id;
                    win.pid = item.pid;
                    win.workspaceId = item.workspace_id ?? -1;
                    win.isFloating = item.is_floating;
                    win.isUrgent = item.is_urgent;
                    win.scrollingColumnIndex = item.layout.pos_in_scrolling_layout?.[0] ?? -1;
                    win.scrollingColumnTileIndex = item.layout.pos_in_scrolling_layout?.[1] ?? -1;
                    win.tileWidth = item.layout.tile_size?.[0] ?? -1;
                    win.tileHeight = item.layout.tile_size?.[1] ?? -1;
                    win.windowWidth = item.layout.window_size[0];
                    win.windowHeight = item.layout.window_size[1];
                    win.windowOffsetInTileX = item.layout.window_offset_in_tile[0];
                    win.windowOffsetInTileY = item.layout.window_offset_in_tile[1];
                    win.focusTimeStampSeconds = item.focus_timestamp?.secs ?? -1;
                    win.focusTimeStampNanos = item.focus_timestamp?.nanos ?? -1;

                    if (item.is_focused && !win.isFocused) {
                        const oldFocusedIndex = root.windows.findIndex(w => w.isFocused);
                        if (oldFocusedIndex !== -1) {
                            root.windows[oldFocusedIndex].isFocused = false;
                            root.windows[oldFocusedIndex] = root.windows[oldFocusedIndex];
                        }
                        root.focusedWindow = win;
                    } else if (!item.is_focused && win.isFocused) {
                        root.focusedWindow = null;
                    }

                    win.isFocused = item.is_focused;
                    root.windows[foundIndex] = win;
                }
            }

            function windowClosed(json: var) {
                const index = root.windows.findIndex(item => item.id === json.id);
                if (index !== -1) {
                    const old = root.windows[index];
                    root.windows.splice(index, 1);

                    if (root.focusedWindow !== null && root.focusedWindow.id === old.id) {
                        root.focusedWindow = null;
                    }

                    old.destroy();
                }
            }

            function windowFocusChanged(json: var) {
                const oldFocusedIndex = root.windows.findIndex(item => item.isFocused);
                if (oldFocusedIndex !== -1) {
                    let oldFocused = root.windows[oldFocusedIndex];
                    oldFocused.isFocused = false;
                    root.windows[oldFocusedIndex] = oldFocused;
                }

                if (json.id === null) {
                    root.focusedWindow = null;
                    return;
                }

                const newFocusedIndex = root.windows.findIndex(item => item.id === json.id);
                if (newFocusedIndex !== -1) {
                    let newFocused = root.windows[newFocusedIndex];
                    newFocused.isFocused = true;
                    root.windows[newFocusedIndex] = newFocused;
                    root.focusedWindow = newFocused;
                }
            }

            function windowFocusTimestampChanged(json: var) {
                const index = root.windows.findIndex(item => item.id === json.id);
                if (index !== -1) {
                    let window = root.windows[index];
                    window.focusTimeStampSeconds = json.focus_timestamp.secs;
                    window.focusTimeStampNanos = json.focus_timestamp.nanos;
                    root.windows[index] = window;

                    // Keep focusedWindow in sync if this is the focused window
                    if (root.focusedWindow !== null && root.focusedWindow.id === json.id) {
                        root.focusedWindow = window;
                    }
                }
            }

            function windowUrgencyChanged(json: var) {
                const index = root.windows.findIndex(item => item.id === json.id);
                if (index !== -1) {
                    let window = root.windows[index];
                    window.isUrgent = json.urgent;
                    root.windows[index] = window;
                }
            }

            function windowLayoutsChanged(json: var) {
                for (const change of json.changes) {
                    const layout = change[1];
                    const index = root.windows.findIndex(item => item.id === change[0]);
                    if (index !== -1) {
                        let window = root.windows[index];

                        window.scrollingColumnIndex = layout.pos_in_scrolling_layout?.[0] ?? -1;
                        window.scrollingColumnTileIndex = layout.pos_in_scrolling_layout?.[1] ?? -1;
                        window.tileWidth = layout.tile_size[0];
                        window.tileHeight = layout.tile_size[1];
                        window.windowWidth = layout.window_size[0];
                        window.windowHeight = layout.window_size[1];
                        window.windowOffsetInTileX = layout.window_offset_in_tile[0];
                        window.windowOffsetInTileY = layout.window_offset_in_tile[1];
                        root.windows[index] = window;

                        // Keep focusedWindow layout props in sync
                        if (root.focusedWindow !== null && root.focusedWindow.id === change[0]) {
                            root.focusedWindow = window;
                        }
                    }
                }
            }

            function keyboardLayoutsChanged(json: var) {
                let layouts = [];

                json = json.keyboard_layouts;
                json.names.forEach((e, i) => {
                    layouts.push(root.createKeyboardLayout(e, (json.current_idx === i)));
                });

                root.keyboardLayouts = layouts;
            }

            function keyboardLayoutSwitched(json: var) {
                root.keyboardLayouts = root.keyboardLayouts.map((e, i) => {
                    e.isActive = (i === json.idx);
                    return e;
                });
            }

            function overviewOpenedOrClosed(json: var) {
                root.isOverview = json.is_open;
            }

            function configLoaded(json: var) {
                root.configLoaded = !json.failed;
            }

            function screenshotCaptured(json: var) {
                root.screenshot(json.path);
            }

            function castChanged(json: var) {
                let casts = [];
                json.casts.forEach(e => {
                    casts.push(root.createCast(e));
                });
                root.casts = casts;
            }

            function castStartedOrChanged(json: var) {
                json = json.cast;
                const index = root.casts.findIndex(cast => cast.streamId === json.stream_id);
                if (index !== -1) {
                    let cast = root.casts[index];
                    cast.sessionId = json.session_id;
                    cast.kind = json.kind;
                    cast.target = Object.keys(json.target)[0];
                    cast.outputName = json.target.Output?.name ?? "";
                    cast.windowId = json.target.Window?.id ?? -1;
                    cast.isDynamicTarget = json.is_dynamic_target;
                    cast.isActive = json.is_active;
                    cast.pid = json.pid ?? -1;
                    cast.pwNodeId = json.pw_node_id ?? -1;
                    root.casts[index] = cast;
                } else {
                    root.casts.push(root.createCast(json));
                }
            }

            function castStopped(json: var) {
                const index = root.casts.findIndex(cast => cast.streamId === json.stream_id);
                if (index !== -1) {
                    const old = root.casts[index];
                    root.casts.splice(index, 1);
                    old.destroy();
                }
            }
        }
    }

    Component {
        id: workspaceComponent
        NiriWorkspace {}
    }

    function createWorkspace(json: var): var {
        return workspaceComponent.createObject(root, {
            id: json.id,
            idx: json.idx,
            name: json.name,
            output: json.output,
            isUrgent: json.is_urgent,
            isActive: json.is_active,
            isFocused: json.is_focused,
            activeWindowId: json.active_window_id ?? -1
        });
    }

    Component {
        id: windowComponent
        NiriWindow {}
    }

    function createWindow(json: var): var {
        return windowComponent.createObject(root, {
            id: json.id,
            title: json.title,
            appId: json.app_id,
            pid: json.pid,
            workspaceId: json.workspace_id ?? -1,
            isFocused: json.is_focused,
            isFloating: json.is_floating,
            isUrgent: json.is_urgent,
            scrollingColumnIndex: json.layout.pos_in_scrolling_layout?.[0] ?? -1,
            scrollingColumnTileIndex: json.layout.pos_in_scrolling_layout?.[1] ?? -1,
            tileWidth: json.layout.tile_size?.[0] ?? -1,
            tileHeight: json.layout.tile_size?.[1] ?? -1,
            windowWidth: json.layout.window_size[0],
            windowHeight: json.layout.window_size[1],
            windowOffsetInTileX: json.layout.window_offset_in_tile[0],
            windowOffsetInTileY: json.layout.window_offset_in_tile[1],
            focusTimeStampSeconds: json.focus_timestamp?.secs ?? -1,
            focusTimeStampNanos: json.focus_timestamp?.nanos ?? -1
        });
    }

    Component {
        id: keyboardLayoutComponent
        NiriKeyboardLayout {}
    }

    function createKeyboardLayout(name: string, isActive: bool): var {
        return keyboardLayoutComponent.createObject(root, {
            name,
            isActive
        });
    }

    Component {
        id: castComponent
        NiriCast {}
    }

    function createCast(json: var): var {
        return castComponent.createObject(root, {
            streamId: json.stream_id,
            sessionId: json.session_id,
            kind: json.kind,
            target: Object.keys(json.target)[0],
            outputName: json.target.Output?.name ?? "",
            windowId: json.target.Window?.id ?? -1,
            isDynamicTarget: json.is_dynamic_target,
            isActive: json.is_active,
            pid: json.pid ?? -1,
            pwNodeId: json.pw_node_id ?? -1
        });
    }
}
