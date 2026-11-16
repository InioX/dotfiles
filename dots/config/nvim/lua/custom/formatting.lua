do
  -- [[ Formatting ]]
  vim.pack.add { 'https://github.com/stevearc/conform.nvim' }
  require('conform').setup {
    notify_on_error = false,
    format_on_save = true,
    default_format_opts = {
      lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
    },
    -- You can also specify external formatters in here.
    formatters_by_ft = {
      html = { 'prettier' },
      css = { 'prettier' },
      toml = { 'taplo' },
      nunjucks = { 'prettier' },
      javascript = { 'prettier' },
      json = { 'prettier' },
      lua = { 'stylua' },
      -- rust = { 'rustfmt' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  }

  vim.keymap.set({ 'n', 'v' }, '<C-f>', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
end
