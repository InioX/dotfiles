vim.pack.add {
  'https://github.com/neogitorg/neogit',
  'https://github.com/sindrets/diffview.nvim',
}

require('neogit').setup {}

vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<cr>', { desc = 'Open Neogit UI' })
