return {
  'folke/trouble.nvim',
  cmd = 'TroubleToggle',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('trouble').setup {
      position = 'bottom',
      icons = true,
      auto_open = false,
      auto_close = false,
      auto_preview = false,
      auto_fold = false,
      use_diagnostic_signs = true,
    }
  end,
  vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { silent = true, noremap = true }),
  vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', { silent = true, noremap = true }),
  vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', { silent = true, noremap = true }),
  vim.keymap.set('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>', { silent = true, noremap = true }),
  vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', { silent = true, noremap = true }),
  vim.keymap.set('n', 'gR', '<cmd>TroubleToggle lsp_references<cr>', { silent = true, noremap = true })
}
