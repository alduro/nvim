return {
  url = "https://codeberg.org/andyg/leap.nvim",
  config = function()
    local leap = require 'leap'
    leap.add_default_mappings = nil
    leap.add_repeat_mappings = nil
  end,
}
