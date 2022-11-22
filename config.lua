--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

require("user.neovim").config()

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "lunar"

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping, TODO: use table to set
-- normal mode
lvim.keys.normal_mode["H"]     = "0"
lvim.keys.normal_mode["L"]     = "$"
lvim.keys.normal_mode["n"]     = "nzz"
lvim.keys.normal_mode["N"]     = "Nzz"
lvim.keys.normal_mode["G"]     = "Gzz"
lvim.keys.normal_mode["{"]     = "{zz"
lvim.keys.normal_mode["}"]     = "}zz"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-h>"] = "<C-w>h"
lvim.keys.normal_mode["<C-j>"] = "<C-w>j"
lvim.keys.normal_mode["<C-k>"] = "<C-w>k"
lvim.keys.normal_mode["<C-l>"] = "<C-w>l"
lvim.keys.normal_mode["<C-n>"] = ":nohl<cr>"
lvim.keys.normal_mode["<C-u>"] = "<Esc>viwU<Esc>"
lvim.keys.normal_mode["<Tab>"] = ":tabnext<cr>"
lvim.keys.normal_mode["<M-j>"] = ":resize +5<cr>"
lvim.keys.normal_mode["<M-k>"] = ":resize -5<cr>"
lvim.keys.normal_mode["<M-h>"] = ":vertical resize -5<cr>"
lvim.keys.normal_mode["<M-l>"] = ":vertical resize +5<cr>"

-- insert mode
lvim.keys.insert_mode["jk"]    = "<Esc>"
lvim.keys.insert_mode["<C-h>"] = "<C-w>h"
lvim.keys.insert_mode["<C-l>"] = "<C-w>l"
lvim.keys.insert_mode["<C-j>"] = "<C-w>j"
lvim.keys.insert_mode["<C-k>"] = "<C-w>k"

if (vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1)
then
	lvim.keys.normal_mode["<C-v>"] = "<Esc>\"+gP"
	lvim.keys.insert_mode["<C-v>"] = "<Esc>\"+gP"
elseif (vim.fn.has("macunix") == 1)
then
	lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
	lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
end
-- unmap a default keymapping
vim.keymap.del("n", "<C-Up>")

-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
	-- for input mode
	i = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-n>"] = actions.cycle_history_next,
		["<C-p>"] = actions.cycle_history_prev,
	},
	-- for normal mode
	n = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
	},
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["c"] = {}
lvim.builtin.which_key.mappings["f"] = {
  name = "+Find",
	f = { "<cmd>Telescope find_files<cr>", "Find Files"},
	h = { "<cmd>Telescope help_tags<cr>", "Vim Tags" },
	r = { "<cmd>Telescope oldfiles<cr>", "History files" },
}
lvim.builtin.which_key.mappings["h"] = {}
lvim.builtin.which_key.mappings["bd"] = {
	"<cmd>BufferKill<cr>", "Kill Buffer"
}
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
	name = "+Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

if (vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1)
then
	lvim.builtin.terminal.active = false
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
	lvim.builtin.terminal.active = true
	lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
end


-- if you don't want all the parsers change this to a table of the ones you want
if (vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1)
then
	lvim.builtin.treesitter.ensure_installed = {
		"c",
		"lua",
	}
else
	lvim.builtin.treesitter.ensure_installed = {
		"bash",
		"c",
		"json",
		"lua",
		"python",
		"yaml",
	}
end

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.highlight.enable = true

lvim.builtin.bufferline.options.always_show_bufferline = true

-- generic LSP settings

-- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
    "sumneko_lua",
    "jsonls",
}
-- change UI setting of `LspInstallInfo`
---@usage disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false

---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

require("user.plugins").config()

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.txt", "*.log", "*.mk", "*.cmake", "Makefile", "makefile" },
	command = "setlocal nowrap tabstop=4 shiftwidth=4 noexpandtab"
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "zsh",
	callback = function()
		-- let treesitter use bash highlight for zsh files as well
		require("nvim-treesitter.highlight").attach(0, "bash")
	end,
})
