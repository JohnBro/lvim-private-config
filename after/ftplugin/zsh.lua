-- let treesitter use bash highlight for zsh files as well
local status_ok, ts_high = require("nvim-treesitter.highlight")
if status_ok then
  ts_high.attach(0, "bash")
end
