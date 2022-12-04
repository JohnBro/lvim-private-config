local M = {}

local UserIcons = require("user.icons")

M.config = function()
  -------------------------
  -- CMP
  -------------------------
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

  -------------------------
  -- Dashboard
  -------------------------
  lvim.builtin.alpha.mode = "custom"
  local alpha_opts = require("user.dashboard").config()
  lvim.builtin.alpha["custom"] = { config = alpha_opts }

  -----------------------
  -- LSP
  -----------------------
  lvim.lsp.installer.setup.ensure_installed = {}
  --- WARN: configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
  --- see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
  vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
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
    { name = "DiagnosticSignWarn", text = UserIcons.misc.warn },
    { name = "DiagnosticSignInfo", text = UserIcons.misc.info },
    { name = "DiagnosticSignHint", text = UserIcons.misc.hint },
  }

  -----------------------
  -- Treesitter
  -----------------------
  local languages = vim.tbl_flatten {
    { "bash", "c", "make", "cmake", "comment", "cpp", "css", "glsl" },
    { "help", "html", "java", "javascript", "jsdoc", "typescript" },
    { "json", "jsonc", "kotlin", "latex" },
    { "markdown", "perl", "php", "python", "lua" },
    { "vim", "vue", "yaml", "toml", "regex" },
  }
  lvim.builtin.treesitter.ensure_installed = languages
  lvim.builtin.treesitter.matchup.enable = true
  lvim.builtin.treesitter.ignore_install = { "haskell" }
  lvim.builtin.treesitter.autotag.enable = true
  lvim.builtin.treesitter.rainbow.enable = true
  lvim.builtin.treesitter.highlight.enable = true
  lvim.builtin.treesitter.incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-n>",
      node_incremental = "<C-n>",
      scope_incremental = "<TAB>",
      node_decremental = "<C-r>",
    },
  }
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
