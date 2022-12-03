local M = {}
local UserIcons = require("user.icons")

-- Refer to: https://github.com/chentoast/marks.nvim
M.config = function()
  require'marks'.setup {
    -- whether to map keybinds or not. default true
    default_mappings = true,
    -- which builtin marks to show. default {}
    -- builtin_marks = { ".", "<", ">", "^" },
    -- whether movements cycle back to the beginning/end of buffer. default true
    cyclic = true,
    -- whether the shada file is updated after modifying uppercase marks. default false
    force_write_shada = false,
    -- how often (in ms) to redraw signs/recompute mark positions. 
    -- higher values will have better performance but may cause visual lag, 
    -- while lower values may cause performance penalties. default 150.
    refresh_interval = 250,
    -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
    -- marks, and bookmarks.
    -- can be either a table with all/none of the keys, or a single number, in which case
    -- the priority applies to all marks.
    -- default 10.
    sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
    -- disables mark tracking for specific filetypes. default {}
    excluded_filetypes = {},
    -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
    -- sign/virttext. Bookmarks can be used to group together positions and quickly move
    -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
    -- default virt_text is "".
    bookmark_0  = {
      sign      = UserIcons.misc.flag,
      virt_text = "Flag",
      -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
      -- defaults to false.
      annotate  = false,
    },
    bookmark_1  = {
      sign      = UserIcons.todo_comments.NOTE,
      virt_text = "NOTE",
      annotate  = true,
    },
    bookmark_2  = {
      sign      = UserIcons.todo_comments.TODO,
      virt_text = "ERROR",
      annotate  = true,
    },
    bookmark_3  = {
      sign      = UserIcons.todo_comments.WARN,
      virt_text = "WARN",
      annotate  = true,
    },
    bookmark_4  = {
      sign      = UserIcons.todo_comments.ERROR,
      virt_text = "ERROR",
      annotate  = false,
    },
    bookmark_5  = {
      sign      = UserIcons.todo_comments.FIX,
      virt_text = "FIX",
      annotate  = true,
    },
    bookmark_6  = {
      sign      = UserIcons.todo_comments.HACK,
      virt_text = "HACK",
      annotate  = false,
    },
    bookmark_7  = {
      sign      = UserIcons.todo_comments.PERF,
      virt_text = "PERF",
      annotate  = false,
    },
    bookmark_8  = {
      sign      = UserIcons.todo_comments.SHIELD,
      virt_text = "SHIELD",
      annotate  = false,
    },
    bookmark_9  = {
      sign      = UserIcons.todo_comments.REFS,
      virt_text = "REFS",
      annotate  = false,
    },
    mappings      = {
      set_next    = "m,",
      set         = "m=",
      delete      = "m-",
      preview     = "m:",
      delete_line = "m/",
      delete_buf  = "dm*",
      prev     = false -- pass false to disable only this default mapping
    }
  }
end

return M
