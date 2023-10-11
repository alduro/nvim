return {
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help indent_blankline.txt`
  opts = {
    space_char_blankline = ' ',
    show_current_context = true,
    show_current_context_start = true,
    show_trailing_blankline_indent = false,
  },
  config = function()
    require('ibl').setup()
  end,
}
