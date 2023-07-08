return {
    {
      "AstroNvim/astrotheme",
      config = function()
        require("astrotheme").setup({
          palette = "astrodark", -- String of the default palette to use when calling `:colorscheme astrotheme`

          termguicolors = true, -- Bool value, toggles if termguicolors are set by AstroTheme.

          terminal_color = true, -- Bool value, toggles if terminal_colors are set by AstroTheme.

          plugin_default = "auto", -- Sets how all plugins will be loaded
                           -- "auto": Uses lazy / packer enabled plugins to load highlights.
                           -- true: Enables all plugins highlights.
                           -- false: Disables all plugins.

          plugins = {              -- Allows for individual plugin overides using plugin name and value from above.
            ["bufferline.nvim"] = false,
          },

          palettes = {
            global = {},             -- Globaly accessible palettes, theme palettes take priority.
            astrodark = {          -- Extend or modify astrodarks palette colors
              bg = "@{surface}",
              fg = "@{on_surface}",
              blue = "@{primary}",
              bg_1 = "@{surface_variant}",
              black = "@{surface}", -- File picker dim
              black_1 = "@{surface_variant}", -- Window dim
              blue_2 = "@{surface}", -- File picker
              grey_4 = "@{surface_variant}", -- Status line
              grey_8 = "@{surface_variant}", -- Focused line
              grey_9 = "@{surface_variant}",
            },
          },

          highlights = {
            global = {             -- Add or modify hl groups globaly, theme specific hl groups take priority.
              modify_hl_groups = function(hl, c)
                hl.PluginColor4 = {fg = c.my_grey, bg = c.none }
              end,
              ["@String"] = {fg = "#ff00ff", bg = "NONE"},
            },
            astrodark = {
              -- first parameter is the highlight table and the second parameter is the color palette table
              modify_hl_groups = function(hl, c) -- modify_hl_groups function allows you to modify hl groups,
                hl.Comment.fg = c.my_color
                hl.Comment.italic = true
              end,
                ["@String"] = {fg = "#ff00ff", bg = "NONE"},
            },
          },
        })
      end,
    },
}