vim.pack.add {
  'https://github.com/folke/persistence.nvim',
}

vim.opt.sessionoptions = { 'buffers', 'curdir', 'folds', 'help', 'tabpages', 'winsize', 'terminal' }

local persistence = require 'persistence'
persistence.setup {}

vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('PersistenceAutoLoad', { clear = true }),
  callback = function()
    if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
      persistence.load()

      vim.schedule(function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_get_option_value('buftype', { buf = buf }) == '' then
            vim.api.nvim_buf_call(buf, function() vim.cmd 'filetype detect' end)
          end
        end
      end)
    end
  end,
})
