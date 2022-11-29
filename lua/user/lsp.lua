local M = {}

M.config = function()
  lvim.lsp.code_lens_refresh = true
  lvim.lsp.diagnostics.virtual_text = false -- remove this line if you want to see inline errors
  lvim.lsp.installer.setup.automatic_installation = false

	-- make sure server will always be installed even if the server is in skipped_servers list
	lvim.lsp.installer.setup.ensure_installed = {
		"sumneko_lua",
		"jsonls",
		"pylsp",
	}

	--- WARN: configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
	--- see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
	vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })

	lvim.lsp.installer.setup.automatic_installation = false
end

return M
