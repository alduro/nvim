return {
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    event = { 'VimEnter' },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'linrongbin16/lsp-progress.nvim',
    },
    config = function()
      -- require('lsp-progress').setup()
      require('codex').status()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'tokyonight',
          component_separators = '|',
          section_separators = '',
        },
        sections = {
          lualine_x = {
            -- invoke `progress` here.
            require('lsp-progress').progress,
          },
        },
      }
    end,
  },
  {
    'linrongbin16/lsp-progress.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lsp-progress').setup()
    end,
  },
}
