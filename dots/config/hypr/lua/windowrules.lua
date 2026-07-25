local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    match = {
        title = ".*Sign in.*"
    },
    float = true,
    size = { 872, 587 },
    center = true
})

hl.window_rule({
    match = {
        title = "^Picture-in-Picture$"
    },
    float = true,
    size = { 462,263 }
})

hl.window_rule({
    name = "nautilus_float",
    match = {
        class = "^(org.gnome.Nautilus|nautilus)$",
    },
    float = true,
    center = true,
})
-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.layer_rule({
  match = { namespace = "quickshell" },
  blur = true,
  ignore_alpha = 0.5,
})
