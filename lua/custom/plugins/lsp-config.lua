return {
  -- LSP Support
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Additional lua configuration, makes nvim stuff amazing!
      {
        'folke/neodev.nvim',
        config = function()
          require('neodev').setup()
        end,
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local builtin = require 'telescope.builtin'

          local opts = { buffer = event.buf }

          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
          -- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
          vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

          vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
          vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
          vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
        end,
      })

      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

      vim.api.nvim_clear_autocmds { group = augroup }
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('Format', { clear = true }),
        callback = function()
          vim.lsp.buf.format { async = false }
        end,
      })

      -- (Optional) Configure lua language server for neovim
      vim.lsp.enable 'lua_ls'
      vim.lsp.enable 'ruby_lsp'
      vim.lsp.enable 'solargraph'
      vim.lsp.enable 'gopls'
      vim.lsp.enable 'ocamllsp'
      vim.lsp.enable 'pylsp'
      vim.lsp.enable 'ts_ls'
      vim.lsp.enable 'tailwindcss'

      local base_on_attach = vim.lsp.config.eslint.on_attach
      vim.lsp.config('eslint', {
        on_attach = function(client, bufnr)
          if not base_on_attach then
            return
          end

          base_on_attach(client, bufnr)
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            command = 'LspEslintFixAll',
          })
        end,
      })

      -- lspconfig.eslint.setup {
      --   on_attach = function(client, bufnr)
      --     vim.api.nvim_create_autocmd('BufWritePre', {
      --       buffer = bufnr,
      --       command = 'EslintFixAll',
      --     })
      --   end,
      -- }

      local on_attach = function(client, bufnr)
        -- format on save
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('Format', { clear = true }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = true }
            end,
          })
        end
      end

      vim.lsp.config('ts_ls', {
        on_attach = on_attach,
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'typescript.tsx' },
        cmd = { 'typescript-language-server', '--stdio' },
      })
    end,
  },
}
