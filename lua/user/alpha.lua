M = {}

M.config = function()
  local text = require "lvim.interface.text"
  lvim.builtin.alpha.active = true
  lvim.builtin.alpha.mode = "dashboard"
  lvim.builtin.alpha.dashboard.section.header = {
    type = "text",
    val = M.dashboard(),
    opts = {
      position = "center",
      hl = "Comment",
    },
  }
  lvim.builtin.alpha.dashboard.section.footer = {
    type = "text",
    val = text.align_center({ width = 0 }, {
      "Johnbro",
      "Powered by lunarvim.org",
    }, 0.5),
    opts = {
      position = "center",
      hl = "Number",
    },
  }
  local status_ok, dashboard = pcall(require, "alpha.themes.dashboard")
  if status_ok then
    local function button(sc, txt, keybind, keybind_opts)
      local b = dashboard.button(sc, txt, keybind, keybind_opts)
      b.opts.hl_shortcut = "Include"
      return b
    end
    table.insert(
      lvim.builtin.alpha.dashboard.section.buttons.val,
      button("h", "  Find Help", '<CMD>Telescope help_tags<CR>')
    )
    table.insert(
      lvim.builtin.alpha.dashboard.section.buttons.val,
      button("b", "  Find bookmarks", "<CMD>Telescope vim_bookmarks all<CR>" ) 
    )
  end
end

M.dashboard = function()
  local headers = {
    {
      [[                               __                ]],
      [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
      [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
      [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
      [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
      [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    },
    {
      [[]],
      [[ ...      (^~^)                              ]],
      [[(°з°)  _ ┐__\|_┌________ __   __ ___ __   __ ]],
      [[|  |  | |       |       |  | |  |   |  |_|  |]],
      [[|   |_| |    ___|  ___  |  |_|  |   |       |]],
      [[|       |   |___| |▀-▀| |       |   |       |]],
      [[|  _    |    ___| |___| |       |   |       |]],
      [[| | |   |   |___|       ||     ||   | ||_|| |]],
      [[|_|  |__|_______|_______| |___| |___|_|   |_|]],
      [[]],
      [[]],
    },
    {
      "",
      "",
      "           ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒          ",
      "         ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒        ",
      "       ▒▒▒▒▒▒▒▒   ▒▒▒▒   ▒▒▒▒▒▒▒▒      ",
      "      ▒▒▒▒▒▒▒▒▒ ██▒▒▒▒ ██▒▒▒▒▒▒▒▒▒     ",
      "      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒     ",
      "      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒     ",
      "      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒     ",
      "      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒     ",
      "      ▒▒▒▒  ▒▒▒▒  ▒▒▒▒  ▒▒▒▒  ▒▒▒▒     ",
      "",
      "      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒     ",
      "",
      "",
    },
    {
      [[ _   _       _            ]],
      [[| \ | |     (_)           ]],
      [[|  \| |_   ___ _ __ ___   ]],
      [[| . ` \ \ / / | '_ ` _ \  ]],
      [[| |\  |\ V /| | | | | | | ]],
      [[\_| \_/ \_/ |_|_| |_| |_| ]],
    },
    {
      "                ⢀⣀⣤⣤⣤⣶⣶⣶⣶⣶⣶⣤⣤⣤⣀⡀                ",
      "             ⣀⣤⣶⣿⠿⠟⠛⠉⠉⠉⠁⠈⠉⠉⠉⠛⠛⠿⣿⣷⣦⣀             ",
      "          ⢀⣤⣾⡿⠛⠉                ⠉⠛⢿⣷⣤⡀          ",
      "         ⣴⣿⡿⠃                      ⠙⠻⣿⣦         ",
      " ⢀⣠⣤⣤⣤⣤⣤⣾⣿⣉⣀⡀                        ⠙⢻⣷⡄       ",
      "⣼⠋⠁   ⢠⣿⡟ ⠉⠉⠉⠛⠛⠶⠶⣤⣄⣀    ⣀⣀      ⢠⣤⣤⡄   ⢻⣿⣆      ",
      "⢻⡄   ⢰⣿⡟        ⢠⣿⣿⣿⠉⠛⠲⣾⣿⣿⣷    ⢀⣾⣿⣿⠁    ⢻⣿⡆     ",
      " ⠹⣦⡀ ⣿⣿⠁        ⢸⣿⣿⡇   ⠻⣿⣿⠟⠳⠶⣤⣀⣸⣿⣿⠇      ⣿⣷     ",
      "   ⠙⢷⣿⡇         ⣸⣿⣿⠃          ⢸⣿⣿⢷⣤⡀     ⢸⣿⡆    ",
      "    ⢸⣿⠇         ⣿⣿⣿     ⣿⣿⣷  ⢠⣿⣿⡏ ⠈⠙⠳⢦⣄  ⠈⣿⡇    ",
      "    ⢸⣿⡆        ⢸⣿⣿⡇     ⣿⣿⣿ ⢀⣿⣿⡟      ⠈⠙⠷⣤⣿⡇    ",
      "    ⠘⣿⡇        ⣼⣿⣿⠁     ⣿⣿⣿ ⣼⣿⣿⠃         ⢸⣿⠷⣄⡀  ",
      "     ⣿⣿        ⣿⣿⡿      ⣿⣿⣿⢸⣿⣿⠃          ⣾⡿ ⠈⠻⣆ ",
      "     ⠸⣿⣧      ⢸⣿⣿⣇⣀⣀⣀⣀⣀⣀⣸⣿⣿⣿⣿⠇          ⣼⣿⠇   ⠘⣧",
      "      ⠹⣿⣧     ⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏          ⣼⣿⠏    ⣠⡿",
      "       ⠘⢿⣷⣄   ⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉         ⢠⣼⡿⠛⠛⠛⠛⠛⠛⠉ ",
      "         ⠻⣿⣦⣄                      ⣀⣴⣿⠟         ",
      "          ⠈⠛⢿⣶⣤⣀                ⣀⣤⣶⡿⠛⠁          ",
      "             ⠉⠻⢿⣿⣶⣤⣤⣀⣀⡀  ⢀⣀⣀⣠⣤⣶⣿⡿⠟⠋             ",
      "                ⠈⠉⠙⠛⠻⠿⠿⠿⠿⠿⠿⠟⠛⠋⠉⠁                ",
    },
  }
  return headers[2]
end

return M
