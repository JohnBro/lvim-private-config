local M = {}

M.config = function()
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
		-- Lsp Enhancement
		{
			"ahmedkhalf/lsp-rooter.nvim",
			event = "BufRead",
			config = function()
				require("lsp-rooter").setup()
			end,
		},
		{
			"rmagatti/goto-preview",
			config = function()
				require('goto-preview').setup {
					width = 120; -- Width of the floating window
					height = 25; -- Height of the floating window
					default_mappings = false; -- Bind default mappings
					debug = false; -- Print debug information
					opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
					post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
					-- You can use "default_mappings = true" setup option
					-- Or explicitly set keybindings
					-- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
					-- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
					-- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
				}
			end
		},
		{
			"ray-x/lsp_signature.nvim",
			event = "BufRead",
			config = function()
				require"lsp_signature".setup({
					doc_lines = 10,
					floating_window = true,
					floating_window_above_cur_line = false,
					extra_trigger_chars = { "(", "," }, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
				})
			end,
		},
		{
			"simrat39/symbols-outline.nvim",
			config = function()
				require('symbols-outline').setup()
			end
		},
	}
end

return M
