local M = {}

M.config = function()
  require('telescope').load_extension('find_pickers')
  require("user.keymappings").set_telescope_find_picker_keymaps()
end

return M
