local colors = require("colors")

hl.workspace_rule({
	workspace = "special:popout",
	gaps_out = 20,
	gaps_in = 0,
	on_created_empty = "ghostty --class=com.term.dropdown",
})

hl.window_rule({
	match = {
		class = "com.term.dropdown",
	},
	opacity = 0.9,
	float = true,
	center = true,
	size = { "monitor_w * 0.98", "monitor_h * 0.95" },
	border_size = 2,
	border_color = colors.primary,
	min_size = { "monitor_w * 0.98", "monitor_h * 0.95" },
	max_size = { "monitor_w", "monitor_h" },
})

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.window_rule({
	match = {
		class = ".*(steam_proton|overwatch).*",
	},
	immediate = true,
	render_unfocused = true,
	content = "game",
})

hl.window_rule({
	match = {
		initial_title = "Discord Popout",
	},
	opacity = 0.85,
	keep_aspect_ratio = true,
	-- size = { 420,263 },
	size = { 100, 200 },
	float = true,
	pin = true,
	no_blur = true,
	content = "video",
	decorate = false,
})

hl.window_rule({
	match = {
		initial_title = "Picture-in-Picture",
	},
	opacity = 0.85,
	keep_aspect_ratio = true,
	size = { 420, 263 },
	-- size = { 263,420 },
	float = true,
	pin = true,
	no_blur = true,
	content = "video",
})

hl.window_rule({
	match = {
		title = ".*Sign in.*",
	},
	float = true,
	size = { 872, 587 },
	center = true,
})

hl.window_rule({
	match = {
		title = "^Picture-in-Picture$",
	},
	float = true,
	size = { 462, 263 },
})

hl.window_rule({
	match = {
		class = "^(org.gnome.Nautilus|nautilus)$",
	},
	float = true,
	center = true,
})

hl.window_rule({
	match = {
		initial_title = "Zenyte Settings",
	},
	size = { 800, 700 },
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
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

hl.layer_rule({
	match = { namespace = "quickshell-(bar|dock)" },
	blur = true,
	blur_popups = true,
	ignore_alpha = 0.5,
})
