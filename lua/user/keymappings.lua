local M = {}
local which_key = lvim.builtin.which_key

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
  which_key.mappings["/"] = {}
  which_key.mappings["b"] = {
    name = "Buffers",
    b = { "<CMD>Telescope buffers<cr>", "Buffers" },
    d = { "<cmd>BufferKill<cr>", "Kill Buffer" },
    e = { "<cmd>BufferLinePickClose<cr>", "Pick which buffer to close" },
    h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
    l = { "<cmd>BufferLineCloseRight<cr>", "Close all to the right", },
    n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
    p = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
    j = { "<cmd>BufferLinePick<cr>", "Jump" },
    D = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory", },
    L = { "<cmd>BufferLineSortByExtension<cr>", "Sort by language", },
	}
	which_key.mappings["bf"] = {}
	which_key.mappings["c"] = {}
	which_key.mappings["f"] = {
		name = "+Find",
		f = { "<cmd>Telescope find_files<cr>", "Find Files"},
		h = { "<cmd>Telescope help_tags<cr>", "Vim Tags" },
		r = { "<cmd>Telescope oldfiles<cr>", "History files" },

	}
	-- which_key.mappings["h"] = {}
  which_key.mappings["LC"] = { "<CMD>Telescope commands<CR>", "Commands" }
	which_key.mappings["P"] = { "<CMD>Telescope projects<CR>", "Projects" }
	which_key.mappings["o"] = { "<CMD>SymbolsOutline<CR>", "Outline" }
  which_key.mappings["x"] = {
    name = "+Text",
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

M.set_hop_keymaps = function()
  local opts = { noremap = true, silent = true }
  map("n", "s", ":HopChar2MW<cr>", opts)
  map("n", "S", ":HopWordMW<cr>", opts)
  map(
    "n",
    "f",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
    {}
  )
  map(
    "n",
    "F",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
    {}
  )
  map(
    "o",
    "f",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
    {}
  )
  map(
    "o",
    "F",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
    {}
  )
  map(
    "",
    "t",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
    {}
  )
  map(
    "",
    "T",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
    {}
  )
end

M.set_easyalign_keymaps = function()
  map("x", "ga", "<Plug>(EasyAlign)", { silent = false } )
  map("n", "ga", "<Plug>(EasyAlign)", { silent = false } )
end

M.set_telescope_find_picker_keymaps = function()
  map("n", "<leader>.", "<CMD>Telescope find_pickers<CR>")
end

M.set_spectre_keymaps = function()
  map("n", "<leader>ss", "<CMD>lua require('spectre').open()<CR>", { silent = false } )
  map("v", "<leader>s", "<Esc>:lua require('spectre').open_visual()<CR>", { silent = false } )
  map("n", "<leader>sw", "<CMD>lua require('spectre').open_visual({select_word=true})<CR>", { silent = false } )
  map("n", "<leader>sx", "viw:lua require('spectre').open_file_search()<CR>", { silent = false } )
end

M.config = function()
	basic_mappings()
	whichkey_mappings()
	plugins_mappings()
end

return M
