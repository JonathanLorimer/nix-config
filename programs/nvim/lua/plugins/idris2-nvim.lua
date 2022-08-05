require('idris2').setup({})

local function idris_bindings()
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(0, ...)
  end
  -- Mappings.
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', '<leader>sa','<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>c',"<Cmd>lua require('idris2.code_action').case_split()<CR>", opts)
  buf_set_keymap('n', '<leader>r',"<Cmd>lua require('idris2.code_action').refine_hole()<CR>", opts)
  buf_set_keymap('n', '<leader>a',"<Cmd>lua require('idris2.code_action').add_clause()<CR>", opts)
  buf_set_keymap('n', '<leader>,',"<Cmd>lua require('idris2.code_action').generate_def()<CR>", opts)
  buf_set_keymap('n', '<leader>sh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>sk', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<leader>sj', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

vim.api.nvim_create_augroup('Idris', {clear = true})
vim.api.nvim_create_autocmd('BufRead', {
    group = 'Idris',
    pattern = '*.idr',
    callback = idris_bindings
})
vim.api.nvim_create_autocmd('BufNewFile', {
    group = 'Idris',
    pattern = '*.idr',
    callback = idris_bindings
})
