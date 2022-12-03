local M = {}

M.config = function()
	require("telescope").load_extension("vim_bookmarks")
	vim.api.nvim_set_keymap("n", "Ml", "<CMD>Telescope vim_bookmarks current_file<CR>", { noremap = true })
	vim.api.nvim_set_keymap("n", "ML", "<CMD>Telescope vim_bookmarks all<CR>", { noremap = true })
end

return M
