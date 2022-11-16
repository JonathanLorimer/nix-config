local map = require'utils'.map

require'bufferline'.setup {
  animation = false,
  auto_hide = true,
  tabpages = true,
  closable = false,
  clickable = false,
  icons = true,
  icon_close_tab = '',
  icon_separator_active = '',
  icon_separator_inactive = '',
}

vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  callback = function()
    if vim.bo.filetype == 'NvimTree' then
      require'bufferline.api'.set_offset(31, 'FileTree')
    end
  end
})

vim.api.nvim_create_autocmd('BufWinLeave', {
  pattern = '*',
  callback = function()
    if vim.fn.expand('<afile>'):match('NvimTree') then
      require'bufferline.api'.set_offset(0)
    end
  end
})

local nvim_tree_events = require('nvim-tree.events')
local nvim_tree_view = require('nvim-tree.view')
local bufferline_api = require('bufferline.api')

local function get_tree_size()
  return nvim_tree_view.View.width
end

nvim_tree_events.subscribe('TreeOpen', function()
  bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('Resize', function()
  bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('TreeClose', function()
  bufferline_api.set_offset(0)
end)

local opts = { noremap = true, silent = true }
-- Tabs
map('', '<leader>H', '<Cmd>BufferMovePrevious<CR>', opts)
map('', '<leader>L', '<Cmd>BufferMoveNext<CR>', opts)
map('', '<leader>h', '<Cmd>BufferPrevious<CR>', opts)
map('', '<leader>l', '<Cmd>BufferNext<CR>', opts)
map('', '<leader>td', ':tab split<CR>', opts)
