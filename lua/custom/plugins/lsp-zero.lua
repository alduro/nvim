return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
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
    }, -- Required
    -- {
    --   -- Optional
    --   'williamboman/mason.nvim',
    --   build = function()
    --     pcall(vim.cmd, 'MasonUpdate')
    --   end,
    -- },
    -- { 'williamboman/mason-lspconfig.nvim' }, -- Optional

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },     -- Required
    { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    { 'L3MON4D3/LuaSnip' },     -- Required
  },
  config = function()
    -- require('lsp-zero').setup()
    local lspconfig = require('lspconfig')
    local lsp_defaults = lspconfig.util.default_config

    lsp_defaults.capabilities = vim.tbl_deep_extend(
      'force',
      lsp_defaults.capabilities,
      require('cmp_nvim_lsp').default_capabilities()
    )

    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local builtin = require('telescope.builtin')

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
      end
    })

    local lsp = require('lsp-zero').preset({
      manage_nvim_cmp = {
        set_sources = 'recommended'
      }
    })

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    vim.api.nvim_clear_autocmds({ group = augroup })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })

    -- (Optional) Configure lua language server for neovim
    lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
    lspconfig.ruby_ls.setup({})
    lspconfig.solargraph.setup({})

    lsp.setup()

    local cmp = require('cmp')

    cmp.setup({
      mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
      },
      sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'copilot' },
        { name = 'buffer',  keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
      }
    })
  end,
}
