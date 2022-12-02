local M = {}
local Banners = require("user.banners")
local dashboard = lvim.builtin.alpha.dashboard
local LvimIcons = require("lvim.icons")
local UserIcons = require("user.icons")

M.config = function()
  dashboard.section.header = {
    type = "text",
    val = Banners.dashboard(2),
    opts = {
      position = "center",
      hl = "Label",
    },
  }

  dashboard.section.buttons.opts.spacing = 0
  table.insert(
    dashboard.section.buttons.entries,
    { "C", UserIcons.misc.command .. "  Commands", "<CMD>Telescope commands"}
  )
  table.insert(
    dashboard.section.buttons.entries,
    { "h", UserIcons.misc.help .. "  Find Help", "<CMD>Telescope help_tags<CR>" }
  )
  table.insert(
    dashboard.section.buttons.entries,
    { "b", LvimIcons.ui.BookMark .. "  Find bookmarks", "<CMD>Telescope vim_bookmarks all<CR>" }
  )
end

return M
