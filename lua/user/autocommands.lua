local M = {}

local create_aucmd = vim.api.nvim_create_autocmd

M.config = function()
  vim.api.nvim_create_augroup("_lvim_user", {})
  -- Autocommands
  create_aucmd(
    { "InsertLeave", "WinEnter" },
    {
      group = "_lvim_user",
      pattern = "*",
      command = "setlocal cursorline"
    }
  )
  create_aucmd(
    { "InsertEnter", "WinLeave" },
    {
      group = "_lvim_user",
      pattern = "*",
      command = "setlocal nocursorline"
    }
  )
  if lvim.builtin.nonumber_unfocus then
    create_aucmd("WinEnter",
      { group = "_lvim_user", pattern = "*", command = "set relativenumber number cursorline" })
    create_aucmd(
      "WinLeave",
      { group = "_lvim_user", pattern = "*", command = "set norelativenumber nonumber nocursorline" })
  end
end

return M
