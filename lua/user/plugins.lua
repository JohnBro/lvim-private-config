local M = {}

M.config = function()
	lvim.plugins = {
		---------------------
		--- Screen Scroll ---
		---------------------
		{
			"karb94/neoscroll.nvim",
			event = "WinScrolled",
			config = function() require("user.plugins.neoscroll").config() end,
		},
		---------------------
		--- Cursor Motion ---
		---------------------
		{
			"rhysd/clever-f.vim",
			keys = { "f", "F", "t", "T" },
			setup = function() require("user.plugins.clever-f").setup() end,
		},
		{
			"phaazon/hop.nvim",
			cmd = "Hop*",
			config = function() require("user.plugins.hop").config() end,
		},
		{
			"andymass/vim-matchup",
			event = "CursorMoved",
			setup = function() require("user.plugins.matchup").setup() end,
		},
		--------------------
		--- Tag Jumpping ---
		--------------------
		{
			"ethanholz/nvim-lastplace",
			event = "BufRead",
			config = function() require("user.plugins.lastplace").config() end,
		},
		{
			"MattesGroeger/vim-bookmarks",
			event = "BufRead",
			setup = function() require("user.plugins.vim-bookmarks").setup() end,
			config = function() require("user.plugins.vim-bookmarks").config() end,
		},
		{
			"tom-anders/telescope-vim-bookmarks.nvim",
			keys = { "ml", "mL" },
			config = function() require("user.plugins.telescope-vim-bookmarks").config() end,
		},
		-----------------
		--- Grep Text ---
		-----------------
		{
			"bronson/vim-visual-star-search",
			keys = { { "v", "*" }, { "v", "#" }, { "v", "g*" }, { "v", "g#" } },
		},
		{
			"romainl/vim-cool",
			event = "CursorMoved",
		},
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			keys = { "<C-M-F>" },
			config = function() require("user.plugins.telescope-live-grep-args").config() end,
		},
		{
			"nacro90/numb.nvim",
			event = "BufRead",
			config = function() require("user.plugins.numb").config() end,
		},
		------------------
		--- Quick Edit ---
		------------------
		{
			"mg979/vim-visual-multi",
			keys = { "<C-n>", { "v", "<C-n>" }, "<C-M-L>", { "v", "<C-M-L>" }, "ma", { "v", "ma" } },
			setup = function() require("user.plugins.vim-visual-multi").setup() end,
			config = function() require("user.plugins.vim-visual-multi").config() end,
		},
		---------------------
		-- LSP Enhancement --
		---------------------
		{
			"j-hui/fidget.nvim",
			event = "BufRead",
			config = function() require("user.plugins.fidget").config() end,
		},
		{
			"ray-x/lsp_signature.nvim",
			event = "BufRead",
			config = function() require("user.plugins.lsp_signature").config() end,
		},
		{
			"benfowler/telescope-luasnip.nvim",
			keys = { "<M-i>" },
			config = function() require("user.plugins.telescope-luasnip").config() end,
		},
		{
			"p00f/clangd_extensions.nvim",
			ft = { "c", "cpp", "objc", "objcpp" },
			config = function() require("user.plugins.clangd_extensions").config() end,
		},
		{
			"windwp/nvim-ts-autotag",
			config = function() require("user.plugins.nvim-ts-autotag").config() end,
		},
		{
			"rmagatti/goto-preview",
			config = function() require("user.plugins.goto-preview").config() end,
		},
		{
			"tzachar/cmp-tabnine",
			run = "./install.sh",
			requires = "hrsh7th/nvim-cmp",
			event = "InsertEnter",
		},
		----------------------
		--- File Operation ---
		----------------------
		{
			"folke/persistence.nvim",
			event = "BufReadPre", -- this will only start session saving when an actual file was opened
			module = "persistence",
			config = function() require("user.plugins.persistence").config() end,
		},
		-----------------------
		--- Buffer Elements ---
		-----------------------
		{
			"petertriho/nvim-scrollbar",
			config = function() require("user.plugins.nvim-scrollbar").config() end,
		},
		{
			"sidebar-nvim/sidebar.nvim",
			cmd = "Sidebar*",
			config = function() require("user.plugins.sidebar").config() end,
		},
		{
			"simrat39/symbols-outline.nvim",
			cmd = "SymbolsOutline*",
			config = function() require("user.plugins.symbols-outline").config() end,
		},
		{
			"folke/todo-comments.nvim",
			event = "BufRead",
			config = function() require("user.plugins.todo-comments").config() end,
		},
		{
			"itchyny/vim-cursorword",
			event = {"BufEnter", "BufNewFile"},
			config = function() require("user.plugins.vim-cursorword").config() end,
		},
		{
			"tpope/vim-surround",
			keys = { "c", "d", "y" },
			-- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
			-- setup = function()
			--  vim.o.timeoutlen = 500
			-- end
		},
		{ "tpope/vim-repeat" },
		--------------------------------
		--- Interface beautification ---
		--------------------------------
		{
			"p00f/nvim-ts-rainbow",
		},
		{
			"norcalli/nvim-colorizer.lua",
			config = function() require("user.plugins.colorizer").config() end,
		},
		---------
		-- Git --
		---------
		{
			"sindrets/diffview.nvim",
			event = "BufRead",
		},
	}
end

return M
