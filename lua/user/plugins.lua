local M = {}

M.config = function()
	lvim.plugins = {
		---------------------
		--- Screen Scroll ---
		---------------------
		{
			"karb94/neoscroll.nvim",
			event = "BufRead",
			config = function() require("user.plugins.neoscroll").config() end,
      disable = lvim.builtin.smooth_scroll ~= "neoscroll",
		},
    {
      "declancm/cinnamon.nvim",
      config = function() require("user.plugins.cinnamon").config() end,
      event = "BufRead",
      disable = lvim.builtin.smooth_scroll ~= "cinnamon",
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
      event = "BufRead",
			config = function() require("user.plugins.hop").config() end,
      disable = lvim.builtin.motion_provider ~= "hop",
		},
    {
      "ggandor/leap.nvim",
      config = function() require("user.plugins.leap").config() end,
      disable = lvim.builtin.motion_provider ~= "leap",
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
			keys = { "ml", "mL", "mm", "mM", "b" },
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
      cmd = "Telescope vim_bookmarks",
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
    {
      'junegunn/vim-easy-align',
      keys = { "ga" },
      cmd = "EasyAlign",
      config = function() require("user.plugins.vim-easy-align").config() end,
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
      config = function()
        local tabnine = require "cmp_tabnine.config"
        tabnine:setup {
          max_lines = 1000,
          max_num_results = 10,
          sort = true,
        }
      end,
      event = "InsertEnter",
      opt = true,
      disable = not lvim.builtin.tabnine.active,
    },
		----------------------
		--- File Operation ---
		----------------------
		{
			"folke/persistence.nvim",
			event = "BufReadPre", -- this will only start session saving when an actual file was opened
			module = "persistence",
			config = function() require("user.plugins.persistence").config() end,
      disable = not lvim.builtin.persistence.active,
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
      disable = not lvim.builtin.cursorword.active,
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
    {
      "lunarvim/bigfile.nvim",
      config = function()
        pcall(function()
          require("bigfile").config(lvim.builtin.bigfile.config)
        end)
      end,
      disable = not lvim.builtin.bigfile.active,
    },
    { "mtdl9/vim-log-highlighting", ft = { "text", "log" } },
		--------------------------------
		--- Interface beautification ---
		--------------------------------
		{
			"p00f/nvim-ts-rainbow",
		},
		{
			"norcalli/nvim-colorizer.lua",
			config = function() require("user.plugins.nvim-colorizer").config() end,
		},
    {
      "b0o/incline.nvim",
      config = function() require("user.plugins.incline").config() end,
      disable = lvim.builtin.winbar_provider ~= "filename",
    },
    {
      "fgheng/winbar.nvim",
      config = function() require("user.plugins.winbar").config() end,
      event = { "InsertEnter", "CursorHoldI" },
      disable = lvim.builtin.winbar_provider ~= "treesitter",
    },
    {
      "SmiteshP/nvim-gps",
      module_pattern = { "gps", "nvim-gps" },
      config = function() require("user.plugins.nvim-gps").config() end,
      requires = "nvim-treesitter/nvim-treesitter",
      event = { "InsertEnter", "CursorHoldI" },
      disable = lvim.builtin.winbar_provider ~= "treesitter",
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
