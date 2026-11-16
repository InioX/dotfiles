do
  vim.loader.enable()

  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  vim.g.have_nerd_font = true

  -- vim.opt.laststatus = 0
  vim.opt.cmdheight = 0

  -- Make line numbers default
  vim.o.number = true
  vim.o.mouse = 'a'

  vim.o.wrap = false

  vim.o.showmode = false

  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

  vim.o.breakindent = true
  vim.o.undofile = true

  vim.o.ignorecase = true
  vim.o.smartcase = true

  vim.o.signcolumn = 'yes'

  vim.o.updatetime = 250
  vim.o.timeoutlen = 300

  vim.o.splitright = true
  vim.o.splitbelow = true

  vim.o.tabstop = 2
  vim.o.shiftwidth = 2
  vim.o.expandtab = true

  -- Sets how neovim will display certain whitespace characters in the editor.
  --  See `:help 'list'`
  --  and `:help 'listchars'`
  --
  --  Notice listchars is set using `vim.opt` instead of `vim.o`.
  --  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
  --   See `:help lua-options`
  --   and `:help lua-guide-options`
  vim.o.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  vim.o.inccommand = 'split'
  vim.o.cursorline = true

  vim.o.confirm = true
end

do
  require 'kickstart.plugins.lint'
  require 'kickstart.plugins.autopairs'
  require 'kickstart.plugins.neo-tree'
  require 'kickstart.plugins.gitsigns'
  require 'custom.plugins'
  require 'custom.keybindings'
  require 'custom.autocomplete'
  require 'custom.lsp'
  require 'custom.formatting'
  require 'custom.treesitter'
  require 'custom.telescope'
  require 'custom.ui'
  require 'custom.neovide'
end
