local M = {}

M.config = function()
  -------------------------
  -- Dashboard
  -------------------------
  lvim.builtin.alpha.mode = "dashboard"
  local alpha_opts = require("user.dashboard").config()

end

return M
