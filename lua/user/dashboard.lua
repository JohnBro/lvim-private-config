M = {}

local Banners        = require("user.banners")
local LvimIcons      = require("lvim.icons")
local UserIcons      = require("user.icons")
local AlphaDashboard = require("alpha.themes.dashboard")
local text           = require "lvim.interface.text"
local lvim_version   = require("lvim.utils.git").get_lvim_version()

local function resolve_buttons(button_section)
  if button_section.val and #button_section.val > 0 then
    return button_section.val
  end

  local val = {}
  for _, entry in pairs(button_section.entries) do
    local on_press = function()
      local sc_ = entry[1]:gsub("%s", ""):gsub("SPC", "<leader>")
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end
    local button_element = AlphaDashboard.button(entry[1], entry[2], entry[3])
    -- this became necessary after recent changes in alpha.nvim (06ade3a20ca9e79a7038b98d05a23d7b6c016174)
    button_element.on_press = on_press

    button_element.opts = vim.tbl_extend("force", button_element.opts, entry[4] or button_section.opts or {})

    table.insert(val, button_element)
  end
  return val
end

local header = {
  type = "text",
  val = Banners.dashboard(2),
  opts = {
    position = "center",
    hl = "Type",
  },
}

local footer = {
  type = "text",
  val = text.align_center({ width = 0 }, {
    "",
    "lunarvim.org",
    lvim_version,
  }, 0.5),
  opts = {
    position = "center",
    hl = "Number",
  },
}

local buttons = {
  type = "group",
  opts = {
    hl_shortcut = "Include",
    spacing = 0,
    width = 45,
  },
  entries = {
    { "f", LvimIcons.ui.FindFile .. "  Find File", "<CMD>Telescope find_files<CR>" },
    { "n", LvimIcons.ui.NewFile .. "  New File", "<CMD>ene!<CR>" },
    { "p", LvimIcons.ui.Project .. "  Projects ", "<CMD>Telescope projects<CR>" },
    { "r", LvimIcons.ui.History .. "  Recent files", ":Telescope oldfiles <CR>" },
    { "t", LvimIcons.ui.FindText .. "  Find Text", "<CMD>Telescope live_grep<CR>" },
    { "c", LvimIcons.ui.Gear .. "  Configuration", "<CMD>edit " .. require("lvim.config"):get_user_config_path() .. " <CR>", },
    { "C", UserIcons.misc.command .. "  Commands", "<CMD>Telescope commands<CR>" },
    { "m", UserIcons.misc.flag .. "  Marks", "<CMD>Telescope marks<CR>" },
    { "b", LvimIcons.ui.BookMark .. "  Find bookmarks", "<CMD>Telescope vim_bookmarks all<CR>" },
    { ".", LvimIcons.kind.Module .. "  Telescope pickers", "<CMD>Telescope find_pickers<CR>" },
    { "h", UserIcons.misc.help .. "  Find Help", "<CMD>Telescope help_tags<CR>" },
  }
}

M.config = function()

  local section = {
    header = header,
    buttons = buttons,
    footer = footer,
  }

  for name, el in pairs(section) do
    for k, v in pairs(el) do
      if name:match "buttons" and k == "entries" then
        section[name].val = resolve_buttons(el)
      elseif v then
        section[name][k] = v
      end
    end
  end

  local fn = vim.fn
  local marginTopPercent = 0.15
  local marginTop = fn.max({ 1, fn.floor(fn.winheight(0) * marginTopPercent) })

  local opts = {
    layout = {
      { type = "padding", val = marginTop },
      section.header,
      { type = "padding", val = 2 },
      section.buttons,
      { type = "padding", val = 1 },
      section.footer,
    },
    opts = {
      margin = 5,
    },
  }

  return opts
end

return M
