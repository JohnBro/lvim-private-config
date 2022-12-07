local M = {}

M.config = function()
  require("spectre").setup()
  require("user.keymappings").set_spectre_keymaps()
end

return M
