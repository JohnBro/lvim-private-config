--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

-- Enable powershell as your default shell
if (vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1)
then
	vim.opt.shell = "pwsh.exe -NoLogo"
	vim.opt.shellcmdflag =
	"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
	vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
		]]
	vim.opt.guifont = "Courier New:h14" -- the font used in graphical neovim applications
	-- Set a compatible clipboard manager
	vim.g.clipboard = {
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
	}
end

vim.opt.timeoutlen = 100 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.rnu = true
vim.opt.cursorcolumn = true

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

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

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

-- Additional Plugins
lvim.plugins = {
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{
		"p00f/nvim-ts-rainbow",
	},
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require('neoscroll').setup({
				-- All these keys will be mapped to their corresponding default scrolling animation
				mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
					'<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
				hide_cursor = true,          -- Hide cursor while scrolling
				stop_eof = true,             -- Stop at <EOF> when scrolling downwards
				use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
				respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
				cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
				easing_function = nil,        -- Default easing function
				pre_hook = nil,              -- Function to run before the scrolling animation starts
				post_hook = nil,              -- Function to run after the scrolling animation ends
			})
		end
	},
	{
		"kevinhwang91/rnvimr",
		cmd = "RnvimrToggle",
		config = function()
			vim.g.rnvimr_draw_border = 1
			vim.g.rnvimr_pick_enable = 1
			vim.g.rnvimr_bw_enable = 1
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"itchyny/vim-cursorword",
		event = {"BufEnter", "BufNewFile"},
		config = function()
			vim.api.nvim_command("augroup user_plugin_cursorword")
			vim.api.nvim_command("autocmd!")
			vim.api.nvim_command("autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")
			vim.api.nvim_command("autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif")
			vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
			vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
			vim.api.nvim_command("augroup END")
		end
	},
	{
		"sindrets/diffview.nvim",
		event = "BufRead",
	},
}

vim.api.nvim_create_augroup("indentGroup")

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.json", "*.jsonc" },
	group   = "indentGroup",
	-- enable wrap mode for json files only
	command = "setlocal wrap",
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.lua" },
	group   = "indentGroup",
	command = "setlocal nowrap tabstop=2 shiftwidth=2 noexpandtab",
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.c", "*.cpp", "*.h", "*.py", "*.php" },
	group   = "indentGroup",
	command = "setlocal nowrap tabstop=4 shiftwidth=4 softtabstop=4 expandtab textwidth=120"
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.txt", "*.log", "*.mk", "*.cmake", "Makefile", "makefile" },
	group   = "indentGroup",
	command = "setlocal nowrap tabstop=4 shiftwidth=4 noexpandtab"
})


vim.api.nvim_create_autocmd("FileType", {
	pattern = "zsh",
	callback = function()
		-- let treesitter use bash highlight for zsh files as well
		require("nvim-treesitter.highlight").attach(0, "bash")
	end,
})
