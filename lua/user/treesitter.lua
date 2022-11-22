local M = {}

local wins_treesitter_lang = {
	"c",
	"lua",
	"python",
}

local unix_treesitter_lang = {
		"bash",
		"vim",
		"lua",
		"c",
		"make",
		"cpp",
		"cmake",
		"go",
		"gomod",
		"python",
		"javascript",
		"typescript",
		"tsx",
		"http",
		"html",
		"css",
		"markdown",
		"json",
		"jsonc",
		"yaml",
		"toml",
		"comment",
		"regex",
		"dockerfile",
}

M.config = function()
	vim.wo.foldmethod = "expr"
	vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
	vim.wo.foldlevel = 4
	vim.wo.foldtext =
		[[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
	vim.wo.foldnestmax = 3
	vim.wo.foldminlines = 1
	lvim.builtin.treesitter.matchup.enable = true
	lvim.builtin.treesitter.ignore_install = { "haskell" }
	lvim.builtin.treesitter.autotag.enable = true
	lvim.builtin.treesitter.rainbow.enable = true
	if vim.fn.has("win32") == 1 or vim.fn.has("win64") then
		lvim.builtin.treesitter.ensure_installed = wins_treesitter_lang
	else
		lvim.builtin.treesitter.ensure_installed = unix_treesitter_lang
	end

	require'nvim-treesitter.configs'.setup {
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<CR>",
				node_incremental = "<CR>",
				node_decremental = "<BS>",
				scope_incremental = "<TAB>",
			},
		},
	}
end

return M
