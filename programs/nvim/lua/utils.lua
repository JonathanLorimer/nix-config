local utils = {}

function utils.map(mode, lhs, rhs, opts, is_buffer_specific)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  if is_buffer_specific
    then vim.api.nvim_buf_set_keymap(mode, lhs, rhs, options)
    else vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  end
end

return utils
