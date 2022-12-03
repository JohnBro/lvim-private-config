local M = {}

M.config = function()
	require("telescope").load_extension("luasnip")
	vim.api.nvim_set_keymap("n", "<M-i>", "<CMD>Telescope luasnip<CR>", { noremap = true, silent = false })
	vim.api.nvim_set_keymap("i", "<M-i>", "<CMD>Telescope luasnip<CR>", { noremap = true, silent = false })
end

return M
