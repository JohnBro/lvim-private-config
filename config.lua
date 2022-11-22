require("user.neovim").config()
require("user.statusline").config()

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "lunar"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.bufferline.options.always_show_bufferline = true
lvim.builtin.terminal.active = true

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
	lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
end

require("user.treesitter").config()
require("user.lsp").config()
require("user.plugins").config()
require("user.keymappings").config()
