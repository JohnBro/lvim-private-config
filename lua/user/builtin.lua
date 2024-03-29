local M = {}

local UserIcons = require("user.icons")

M.config = function()
  ---------------
  --- which_key
  ---------------
  which_key                         = lvim.builtin.which_key
  which_key.setup.plugins.registers = true
  which_key.setup.plugins.marks     = true
  which_key.setup.plugins.presets   = {
    operators = false, -- adds help for operators like d, y, ...
    motions = false, -- adds help for motions
    text_objects = true, -- help for text objects triggered after entering an operator
    windows = true, -- default bindings on <c-w>
    nav = true, -- misc bindings to work with windows
    z = true, -- bindings for folds, spelling and others prefixed with z
    g = true, -- bindings for prefixed with g
  }

  ------------------
  --- Bufferline ---
  ------------------
  if lvim.builtin.bufferline.active then
    local bufferline                          = lvim.builtin.bufferline
    bufferline.options.always_show_bufferline = true
  end

  -----------
  --- CMP ---
  -----------
  lvim.builtin.cmp.sources = {
    { name = "nvim_lsp" },
    { name = "cmp_tabnine", max_item_count = 3 },
    { name = "buffer", max_item_count = 5, keyword_length = 5 },
    { name = "path", max_item_count = 5 },
    { name = "luasnip", max_item_count = 3 },
    { name = "nvim_lua" },
    { name = "calc" },
    { name = "emoji" },
    { name = "treesitter" },
    { name = "latex_symbols" },
    { name = "crates" },
    { name = "orgmode" },
  }

  -----------------
  --- Dashboard ---
  -----------------
  lvim.builtin.alpha.mode = "custom"
  local alpha_opts = require("user.dashboard").config()
  lvim.builtin.alpha["custom"] = { config = alpha_opts }

  -----------
  --- LSP ---
  -----------
  lvim.lsp.installer.setup.ensure_installed = {}
  --- WARN: configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
  --- see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
  vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jedi_language_server" })
  lvim.lsp.diagnostics.virtual_text = false -- remove this line if you want to see inline errors
  lvim.lsp.installer.setup.automatic_installation = false -- set as true if you want to auto install
  lvim.lsp.buffer_mappings.normal_mode["K"] = {
    "<cmd>lua require('user.builtin').show_documentation()<CR>",
    "Show Documentation",
  }

  lvim.lsp.float.border = {
    { "╔", "FloatBorder" },
    { "═", "FloatBorder" },
    { "╗", "FloatBorder" },
    { "║", "FloatBorder" },
    { "╝", "FloatBorder" },
    { "═", "FloatBorder" },
    { "╚", "FloatBorder" },
    { "║", "FloatBorder" },
  }
  lvim.lsp.diagnostics.float.border = {
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
  }
  lvim.lsp.diagnostics.signs.values = {
    { name = "DiagnosticSignError", text = UserIcons.misc.error },
    { name = "DiagnosticSignWarn", text  = UserIcons.misc.warn },
    { name = "DiagnosticSignInfo", text  = UserIcons.misc.info },
    { name = "DiagnosticSignHint", text  = UserIcons.misc.hint },
  }

  -----------------------
  -- Treesitter
  -----------------------
  local treesitter = lvim.builtin.treesitter
  local languages  = vim.tbl_flatten {
    { "bash", "c", "make", "cmake", "comment", "cpp", "css", "glsl" },
    { "help", "html", "java", "javascript", "jsdoc", "typescript" },
    { "json", "jsonc", "kotlin", "latex", "org" },
    { "markdown", "markdown_inline", "perl", "php", "python", "lua" },
    { "vim", "vue", "yaml", "toml", "regex" },
  }
  treesitter.ensure_installed = languages
  treesitter.matchup.enable   = true
  treesitter.ignore_install   = { "haskell" }
  treesitter.autotag.enable   = true
  treesitter.rainbow.enable   = true
  treesitter.highlight.enable = true
  treesitter.highlight.additional_vim_regex_highlighting = {
    "markdown",
    "org",
  }
  treesitter.incremental_selection = {
    enable  = true,
    keymaps = {
      init_selection    = "<leader>xv",
      node_incremental  = "v",
      scope_incremental = "<TAB>",
      node_decremental  = "V",
    },
  }

  ----------------
  --- Nvimtree ---
  ----------------
  local nvimtree = lvim.builtin.nvimtree
  nvimtree.setup.diagnostics = {
    enable = true,
    icons  = {
      hint    = UserIcons.misc.hint,
      info    = UserIcons.misc.info,
      warning = UserIcons.misc.warn,
      error   = UserIcons.misc.error,
    }
  }
  if (vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1) then
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
    lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
  end


  ---------------
  --- Project ---
  ---------------
  lvim.builtin.project.active            = true
  lvim.builtin.project.detection_methods = { "lsp" }

  ----------------
  --- Terminal ---
  ----------------
  if (vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1) then
    lvim.builtin.terminal.shell = "pwsh.exe -NoLogo"
    lvim.builtin.terminal.open_mapping = "<C-Space>" -- <C-`>
  elseif (vim.fn.has("macunix")) == 1 then
    lvim.builtin.terminal.open_mapping = "<C-`>" -- <C-`>
    lvim.builtin.terminal.shell = "/bin/zsh"
  else
    lvim.builtin.terminal.open_mapping = "<C-Space>" -- <C-`>
    lvim.builtin.terminal.shell = "/bin/bash"
  end
end

M.show_documentation = function()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand "<cword>")
  elseif vim.fn.expand "%:t" == "Cargo.toml" then
    require("crates").show_popup()
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand "<cword>")
  elseif filetype == "rust" then
    local found, rt = pcall(require, "rust-tools")
    if found then
      rt.hover_actions.hover_actions()
    else
      vim.lsp.buf.hover()
    end
  else
    vim.lsp.buf.hover()
  end
end

return M
