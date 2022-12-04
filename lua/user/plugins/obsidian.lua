local M = {}

local ob_dir = vim.fn.getenv("OBSIDIAN_DIR") ~= vim.NIL or "~/obsidian"

M.config = function()
  require("obsidian").setup({
    dir = ob_dir,
    notes_subdir = "notes",
    daily_notes = {
      folder = "notes/dailies",
    }
  })
end

return M
