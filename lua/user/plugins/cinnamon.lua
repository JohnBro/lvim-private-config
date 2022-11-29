M = {}

M.config = function()
  require("cinnamon").setup {
    default_keymaps = true,
    default_delay = 4,
    extra_keymaps = true,
    extended_keymaps = false,
    centered = true,
    scroll_limit = 100,
  }
end

return M
