-- Neovim
-- =========================================
lvim.leader = "space"
lvim.colorscheme = "lunar" -- set to a custom theme
lvim.builtin.time_based_themes = true -- set false to use your own configured theme
lvim.transparent_window = false -- enable/disable transparency
lvim.debug = false
vim.lsp.set_log_level("error")
lvim.log.level = "warn"
lvim.format_on_save.enabled = false

-- general
lvim.builtin.nvimtree.active = true
lvim.builtin.terminal.active = true
lvim.builtin.alpha.active = true
lvim.builtin.smooth_scroll = "neoscroll" -- for smoth scrolling, can be "cinnamon", "neoscroll" or ""
lvim.builtin.tabnine = { active = true } -- change to false if you don't like tabnine
lvim.builtin.persistence = { active = true } -- change to false if you don't want persistence
lvim.builtin.dap.active = false -- change this to enable/disable debugging
lvim.builtin.motion_provider = "hop" -- change this to use different motion providers ( clever or hop or leap )
lvim.builtin.winbar_provider = "filename" -- can be "filename" or "treesitter" or "navic" or ""
lvim.builtin.nonumber_unfocus = false -- diffrentiate between focused and non focused windows
lvim.builtin.neogit = { active = false } -- use neogit(magit) for git
lvim.builtin.illuminate.active = true -- highlight word under the cursor using either LSP, Tree-sitter, or regex matching

require("user.neovim").config()
require("user.builtin").config()
require("user.statusline").config()
require("user.autocommands").config()
require("user.plugins").config()
require("user.keymappings").config()
