vim.api.nvim_command("setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8 textwidth=120")
require("lvim.lsp.manager").setup("jedi_language_server")
