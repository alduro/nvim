return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v2.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      window = {
        width = 40,
      },
      buffers = {
        follow_current_file = true,
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        show_unloaded = true,
        window = {
          mappings = {
            ['bd'] = 'buffer_delete',
            ['<bs>'] = 'navigate_up',
            ['.'] = 'set_root',
          },
        },
      },
      filesystem = {
        follow_current_file = true,
        filtered_items = {
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_hidden = true,
          hide_by_name = {
            'node_modules',
          },
          never_show = {
            '.DS_Store',
            'thumbs.db',
          },
        },
      },
    }
    vim.api.nvim_set_keymap('n', '<C-e>', ':NeoTreeShowToggle<cr>', { silent = true })
  end,
}
