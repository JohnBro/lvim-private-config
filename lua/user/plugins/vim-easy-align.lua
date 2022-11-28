M = {}

M.config = function()
  vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", { silent = false} )
  vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", { silent = false} )
end

return M
