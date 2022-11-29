-- Neovim
-- =========================================
lvim.leader = "space"
lvim.colorscheme = "lunar" -- set to a custom theme
lvim.builtin.time_based_themes = true -- set false to use your own configured theme
lvim.transparent_window = false -- enable/disable transparency
lvim.debug = false
vim.lsp.set_log_level "error"
lvim.log.level = "warn"

require("user.neovim").config()
require("user.alpha").config()
require("user.statusline").config()

-- general
lvim.format_on_save.enabled = false
lvim.builtin.tabnine = { active = true } -- change to false if you don't like tabnine
lvim.builtin.bufferline.options.always_show_bufferline = true
lvim.builtin.terminal.active = true
lvim.builtin.terminal.open_mapping = "<C-Space>" -- <C-`>

if (vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1) then
	lvim.builtin.terminal.shell = "pwsh.exe -NoLogo"

	-- nvim-tree has some performance issues on windows, see kyazdani42/nvim-tree.lua#549
	lvim.builtin.nvimtree.setup.diagnostics.enable = nil
	lvim.builtin.nvimtree.setup.filters.custom = nil
	lvim.builtin.nvimtree.setup.git.enable = nil
	lvim.builtin.nvimtree.setup.update_cwd = nil
	lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = nil
	lvim.builtin.nvimtree.setup.view.side = "left"
	lvim.builtin.nvimtree.setup.renderer.highlight_git = nil
	lvim.builtin.nvimtree.setup.renderer.icons.show.git = nil
else
	lvim.builtin.terminal.shell = "/bin/bash"
	lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
end

require("user.treesitter").config()
require("user.lsp").config()
require("user.plugins").config()
require("user.keymappings").config()
