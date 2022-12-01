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

	if (vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1) then
		vim.opt.shell = "pwsh.exe -NoLogo"
		vim.opt.shellcmdflag =
		"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
		vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
		]]
		vim.opt.guifont = "Fira Code:h14" -- the font used in graphical neovim applications
		-- Set a compatible clipboard manager
		vim.g.clipboard = {
      name = "win32-yank",
			copy = {
				["+"] = "win32yank.exe -i --crlf",
				["*"] = "win32yank.exe -i --crlf",
			},
			paste = {
				["+"] = "win32yank.exe -o --lf",
				["*"] = "win32yank.exe -o --lf",
			},
		}
  elseif (vim.fn.has("wsl") == 1) then
		vim.g.clipboard = {
			name = "win32yank-wsl",
			copy = {
				["+"] = "win32yank.exe -i --crlf",
				["*"] = "win32yank.exe -i --crlf",
			},
			paste = {
				["+"] = "win32yank.exe -o --lf",
				["*"] = "win32yank.exe -o --lf",
			},
			cache_enabled = 0,
		}
	else
			vim.opt.guifont = "NerdCodePro Font:h13"
	end

  vim.opt.autowriteall = true -- automatically :write before running commands and changing files
	vim.opt.backup = true
	vim.opt.backupdir = join_paths(get_cache_dir(), "backup")
	vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
  vim.opt.completeopt = { "menu", "menuone", "noselect" }
	vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
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
  vim.opt.formatoptions = {
    ["1"] = true,
    ["2"] = true, -- Use indent from 2nd line of a paragraph
    q = true, -- continue comments with gq"
    c = true, -- Auto-wrap comments using textwidth
    r = true, -- Continue comments when pressing Enter
    n = true, -- Recognize numbered lists
    t = false, -- autowrap lines using text width value
    j = true, -- remove a comment leader when joining lines.
    -- Only break if the line was not longer than 'textwidth' when the insert
    -- started and only at a white character that has been entered during the
    -- current insert command.
    l = true,
    v = true,
  }
	vim.opt.guicursor = "n:block-blinkon10,i-ci:ver15-blinkon10,c:hor15-blinkon10,v-sm:block,ve:ver15,r-cr-o:hor10"
  vim.opt.joinspaces = false
  vim.opt.list = true
  vim.opt.listchars = {
    eol = nil,
    tab = "│ ",
    extends = "›", -- Alternatives: … »
    precedes = "‹", -- Alternatives: … «
    trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
  }
	vim.opt.pumblend = 10
	vim.opt.number = true
	vim.opt.relativenumber = true
  vim.opt.redrawtime = 1500
	vim.opt.spell = false
	vim.opt.spelllang = "en"
  vim.opt.shortmess = {
    t = true, -- truncate file messages at start
    A = true, -- ignore annoying swap file messages
    o = true, -- file-read message overwrites previous
    O = true, -- file-read message overwrites previous
    T = true, -- truncate non-file messages in middle
    f = true, -- (file x of x) instead of just (x of x
    F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
    s = true,
    c = true,
    W = true, -- Don't show [w] or written when writing
  }
	vim.opt.timeoutlen = 250
  vim.opt.termguicolors = true
  vim.opt.ttimeoutlen = 10
	vim.opt.updatetime = 100 -- faster completion
	vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
	vim.opt.undofile = true -- enable persistent undo
	vim.opt.wildignorecase = true
  vim.opt.wrapscan = true -- Searches wrap around the end of the file
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
  vim.opt.wrap = true

  vim.o.secure = true -- Disable autocmd etc for project local vimrc files.
  vim.o.exrc = false -- Allow project local vimrc files example .nvimrc see :h exrc
  vim.o.qftf = "{info -> v:lua._G.qftf(info)}"
  -- vim.o.conceallevel = 2 -- uncomment if you want to see concealed text

  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
  vim.wo.foldlevel = 4
  vim.wo.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
  vim.wo.foldnestmax = 3
  vim.wo.foldminlines = 1

  vim.g.dashboard_enable_session = 0
  vim.g.dashboard_disable_statusline = 1

  if vim.g.nvui then
    -- Configure nvui here
    vim.cmd [[NvuiCmdFontFamily FiraCode Nerd Font]]
    vim.cmd [[set linespace=1]]
    vim.cmd [[set guifont=FiraCode\ Nerd\ Font:h14]]
    vim.cmd [[NvuiPopupMenuDefaultIconFg white]]
    vim.cmd [[NvuiCmdBg #1e2125]]
    vim.cmd [[NvuiCmdFg #abb2bf]]
    vim.cmd [[NvuiCmdBigFontScaleFactor 1.0]]
    vim.cmd [[NvuiCmdPadding 10]]
    vim.cmd [[NvuiCmdCenterXPos 0.5]]
    vim.cmd [[NvuiCmdTopPos 0.0]]
    vim.cmd [[NvuiCmdFontSize 20.0]]
    vim.cmd [[NvuiCmdBorderWidth 5]]
    vim.cmd [[NvuiPopupMenuIconFg variable #56b6c2]]
    vim.cmd [[NvuiPopupMenuIconFg function #c678dd]]
    vim.cmd [[NvuiPopupMenuIconFg method #c678dd]]
    vim.cmd [[NvuiPopupMenuIconFg field #d19a66]]
    vim.cmd [[NvuiPopupMenuIconFg property #d19a66]]
    vim.cmd [[NvuiPopupMenuIconFg module white]]
    vim.cmd [[NvuiPopupMenuIconFg struct #e5c07b]]
    vim.cmd [[NvuiCaretExtendTop 15]]
    vim.cmd [[NvuiCaretExtendBottom 8]]
    vim.cmd [[NvuiTitlebarFontSize 12]]
    vim.cmd [[NvuiTitlebarFontFamily Arial]]
    vim.cmd [[NvuiCursorAnimationDuration 0.1]]
    -- vim.cmd [[NvuiToggleFrameless]]
    vim.cmd [[NvuiOpacity 0.99]]
  end
end

-- credit: https://github.com/nyngwang/NeoZoom.lua
function M.maximize_current_split()
  local cur_win = vim.api.nvim_get_current_win()
  vim.api.nvim_set_var("non_float_total", 0)
  vim.cmd "windo if &buftype != 'nofile' | let g:non_float_total += 1 | endif"
  vim.api.nvim_set_current_win(cur_win or 0)
  if vim.api.nvim_get_var "non_float_total" == 1 then
    if vim.fn.tabpagenr "$" == 1 then
      return
    end
    vim.cmd "tabclose"
  else
    local last_cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd "tabedit %:p"
    vim.api.nvim_win_set_cursor(0, last_cursor)
  end
end

return M
