local M = {}

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function unmap(mode, key)
	vim.api.nvim_del_keymap(mode, key)
end

local function basic_mappings()
	--------------------
	-- Basic Mappings --
	--------------------
	map("i", "jk", "<Esc>")

	-------------------
	-- Cursor motion --
	-------------------
	map("c", "<C-a>", "<C-b>")
	map("n", "n", "nzz")
	map("n", "N", "Nzz")
	map("n", "G", "Gzz")
	map("n", "{", "{zz")
	map("n", "}", "}zz")
	map("i", "<C-h>", "<C-w>h")
	map("i", "<C-l>", "<C-w>l")
	map("i", "<C-j>", "<C-w>j")
	map("i", "<C-k>", "<C-w>k")
	map("n", "<C-h>", "<C-w>h")
	map("n", "<C-j>", "<C-w>j")
	map("n", "<C-k>", "<C-w>k")
	map("n", "<C-l>", "<C-w>l")

	------------------
	-- Copy & Paste --
	------------------
	if (vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1)
	then
		-- map("n", "<C-v>", "\"+gP", { noremap = true, silent = false })
		-- map("i", "<C-v>", "\"+gP", { noremap = true, silent = false })
	elseif (vim.fn.has("macunix") == 1)
	then
		map("n", "<S-l>", ":BufferLineCycleNext<cr>", { silent = false })
		map("n", "<S-h>", ":BufferLineCyclePrev<cr>", { silent = false })
	end

	---------------------
	-- File Operations --
	---------------------
	map("n", "<C-s>", ":w<cr>", { silent = false })
	map("n", "<C-u>", "<Esc>viwU<Esc>", { silent = false })
	map("n", "<Tab>", ":tabnext<cr>", { silent = false })
	map("n", "<M-j>", ":resize +5<cr>", { silent = false })
	map("n", "<M-k>", ":resize -5<cr>", { silent = false })
	map("n", "<M-h>", ":vertical resize -5<cr>", { silent = false })
	map("n", "<M-l>", ":vertical resize +5<cr>", { silent = false })

	---------------
	-- Unmap key --
	---------------
	-- unmap("n", "<C-Up>")
end

local function whichkey_mappings()
	lvim.leader = "space"
	lvim.builtin.which_key.mappings["bd"] = {
		"<cmd>BufferKill<cr>", "Kill Buffer",
	}
	lvim.builtin.which_key.mappings["bb"] = {
		"<cmd>Telescope buffers<cr>", "Buffers",
	}
	lvim.builtin.which_key.mappings["bf"] = {}
	lvim.builtin.which_key.mappings["c"] = {}
	lvim.builtin.which_key.mappings["e"] = {}
	lvim.builtin.which_key.mappings["f"] = {
		name = "+Find",
		f = { "<cmd>Telescope find_files<cr>", "Find Files"},
		h = { "<cmd>Telescope help_tags<cr>", "Vim Tags" },
		r = { "<cmd>Telescope oldfiles<cr>", "History files" },
	}
	lvim.builtin.which_key.mappings["h"] = {}
	lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
	lvim.builtin.which_key.mappings["t"] = {
		name = "+Toggle",
		e = { "<CMD>NvimTreeToggle<CR>", "Explorer" },
		o = { "<CMD>SymbolsOutline<CR>", "SymbolsOutline" }
	}
end

local function plugins_mappings()
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
			["<Esc>"] = actions.close,
		},
		-- for normal mode
		n = {},
	}
end

M.config = function()
	basic_mappings()
	whichkey_mappings()
	plugins_mappings()
end

return M
