local M = {}

M.config = function()
	local disabled_plugins = {
		"2html_plugin",
		"getscript",
		"getscriptPlugin",
		"gzip",
		"logipat",
		"netrw",
		"netrwPlugin",
		"netrwSettings",
		"netrwFileHandlers",
		"matchit",
		"tar",
		"tarPlugin",
		"rrhelper",
		"spellfile_plugin",
		"vimball",
		"vimballPlugin",
		"zip",
		"zipPlugin",
	}
	for _, plugin in pairs(disabled_plugins) do
		vim.g["loaded_" .. plugin] = 1
	end

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
		vim.opt.guifont = "Courier New:h13" -- the font used in graphical neovim applications
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
	else
			vim.opt.guifont = "NerdCodePro Font:h13"
	end

	vim.opt.backup = true
	vim.opt.backupdir = join_paths(get_cache_dir(), "backup")
	vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
	vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
	vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
	vim.opt.cursorcolumn = true
	-- Cursorline highlighting control
	-- Only have it on in the active buffer
	vim.opt.cursorline = true -- Highlight the current line
	if vim.fn.has("nvim-0.7") ~= 0 then
		local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
		vim.api.nvim_create_autocmd("WinLeave", {
			group = group,
			callback = function()
				vim.opt_local.cursorline = false
			end,
		})
		vim.api.nvim_create_autocmd("WinEnter", {
			group = group,
			callback = function()
				if vim.bo.filetype ~= "alpha" then
					vim.opt_local.cursorline = true
				end
			end,
		})
	end
	vim.opt.confirm = true -- make vim prompt me to save before doing destructive things
	vim.opt.directory = join_paths(get_cache_dir(), "swap")
	vim.opt.diffopt = {
		"internal",
		"filler",
		"closeoff",
		"hiddenoff",
		"algorithm:minimal",
	}
	if vim.fn.has("nvim-0.7") ~= 0 then
		vim.opt.fillchars = {
			fold = " ",
			eob = " ", -- suppress ~ at EndOfBuffer
			diff = "╱", -- alternatives = ⣿ ░ ─
			msgsep = "‾",
			foldopen = "▾",
			foldsep = "│",
			foldclose = "▸",
			horiz = "━",
			horizup = "┻",
			horizdown = "┳",
			vert = "┃",
			vertleft = "┫",
			vertright = "┣",
			verthoriz = "╋",
		}
	else
		vim.opt.fillchars = {
			vert = "▕", -- alternatives │
			fold = " ",
			eob = " ", -- suppress ~ at EndOfBuffer
			diff = "╱", -- alternatives = ⣿ ░ ─
			msgsep = "‾",
			foldopen = "▾",
			foldsep = "│",
			foldclose = "▸",
		}
	end
	vim.opt.guicursor = "n:block-blinkon10,i-ci:ver15-blinkon10,c:hor15-blinkon10,v-sm:block,ve:ver15,r-cr-o:hor10"
	-- vim.opt.pumblend = 10
	vim.opt.number = true
	vim.opt.relativenumber = true
	vim.opt.spell = false
	vim.opt.spelllang = "en"
	vim.opt.timeoutlen = 250
	vim.opt.updatetime = 300 -- faster completion
	vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
	vim.opt.undofile = true -- enable persistent undo
	vim.opt.wildignorecase = true
	vim.opt.wildignore = {
		"*.aux,*.out,*.toc",
		"*.o,*.obj,*.dll,*.jar,*.pyc,__pycache__,*.rbc,*.class",
		-- media
		"*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp",
		"*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm",
		"*.eot,*.otf,*.ttf,*.woff",
		"*.doc,*.pdf",
		-- archives
		"*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz",
		-- temp/system
		"*.*~,*~ ",
		"*.swp,.lock,.DS_Store,._*,tags.lock",
		-- version control
		".git,.svn",
	}


end

return M
