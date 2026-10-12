vim.pack.add { 'https://github.com/L3MON4D3/LuaSnip' }
require('luasnip').setup {}

vim.pack.add { 'https://github.com/rafamadriz/friendly-snippets' }
require('luasnip.loaders.from_vscode').lazy_load {}
require('luasnip.loaders.from_lua').lazy_load { paths = vim.fn.stdpath 'config' .. '/snippets' }
