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
      local lspconfig = require 'lspconfig'

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

      -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      --
      -- vim.api.nvim_clear_autocmds({ group = augroup })
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   group = augroup,
      --   callback = function()
      --     print("Formatting")
      --     vim.lsp.buf.format({ async = false })
      --   end,
      -- })
      --
      -- (Optional) Configure lua language server for neovim
      lspconfig.lua_ls.setup {}
      -- lspconfig.ruby_ls.setup({})
      lspconfig.solargraph.setup {}
      lspconfig.gopls.setup {
        cmd = { 'gopls', 'serve' },
        settings = {
          gopls = {
            codelenses = {
              generate = false,
              gc_details = true,
            },
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      }
      lspconfig.ocamllsp.setup {}
      lspconfig.pylsp.setup {
        pylint = { enabled = true, executable = 'pylint' },
      }

      lspconfig.elixirls.setup {
        cmd = { '/Users/aldonievas/.config/elixir-ls/release/language_server.sh' },
        flags = {
          debounce_text_changes = 150,
        },
        elixirLS = {
          dialyzerEnabled = false,
          fetchDeps = false,
        },
      }

      lspconfig.eslint.setup {
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            command = 'EslintFixAll',
          })
        end,
      }

      -- local on_attach = function(client, bufnr)
      --   -- format on save
      --   if client.server_capabilities.documentFormattingProvider then
      --     vim.api.nvim_create_autocmd('BufWritePre', {
      --       group = vim.api.nvim_create_augroup('Format', { clear = true }),
      --       buffer = bufnr,
      --       callback = function()
      --         vim.lsp.buf.formatting_seq_sync()
      --       end,
      --     })
      --   end
      -- end

      -- TypeScript
      lspconfig.ts_ls.setup {
        -- on_attach = on_attach,
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'typescript.tsx' },
        cmd = { 'typescript-language-server', '--stdio' },
      }
      lspconfig.tailwindcss.setup {}
    end,
  },
}
