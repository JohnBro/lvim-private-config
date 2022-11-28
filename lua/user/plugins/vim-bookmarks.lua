local M = {}

M.setup = function()
	vim.g.bookmark_sign = ""
	vim.g.bookmark_annotation_sign = ""
	vim.g.bookmark_display_annotation = 1
	vim.g.bookmark_no_default_key_mappings = 1
	vim.g.bookmark_auto_save_file = join_paths(get_cache_dir(), "vim-bookmarks")
end

M.config = function()
	vim.cmd([[hi link BookmarkSign TodoSignTODO]])
	vim.cmd([[hi link BookmarkAnnotationSign TodoSignTODO]])
	vim.api.nvim_set_keymap("n", "mm", "<CMD>BookmarkToggle<CR>", { noremap = true })
	vim.api.nvim_set_keymap("n", "mM", "<CMD>BookmarkAnnotate<CR>", { noremap = true })
end

return M
