local M = {}
local status_ok

M.config = function()
  local orgmode
 -- status_ok, orgmode = pcall(require, "orgmode")
  --if status_ok then
    orgmode.setup({
      org_agenda_files = {'~/Notes/org/*', '~/Documents/org/*' },
      org_default_notes_file = '~/Notes/org/refile.org',
    })
  --end
end

return M
