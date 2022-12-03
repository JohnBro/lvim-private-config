local M = {}

M.setup = function()
	vim.cmd([[
    " VM will override <BS>
    function! VM_Start()
      iunmap <buffer><Bs>
    endf
    function! VM_Exit()
      exe 'inoremap <buffer><expr><BS> v:lua.MPairs.autopairs_bs('.bufnr().')'
    endf
  ]])
end

M.config = function()
	vim.api.nvim_set_keymap("n", "<C-M-L>", "<Plug>(VM-Select-All)", {})
	vim.api.nvim_set_keymap("v", "<C-M-L>", "<Plug>(VM-Visual-All)", {})
	vim.api.nvim_set_keymap("n", "Ma", "<Plug>(VM-Add-Cursor-At-Pos)", {})
	vim.api.nvim_set_keymap("v", "Ma", "<Plug>(VM-Visual-Add)", {})
end

return M
