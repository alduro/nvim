return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  -- dependencies = {
  --   'nvim-treesitter/nvim-treesitter-textobjects',
  -- },
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install({ 'go','lua','ruby','tsx','typescript', 'javascript', 'zig' }):wait(300000) -- wait max. 5 minutes
  end,
}
