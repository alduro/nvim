return {
  'ggandor/leap.nvim',
  name = 'leap',
  config = function()
    local leap = require 'leap'
    leap.add_default_mappings = nil
    leap.add_repeat_mappings = nil
  end,
}
