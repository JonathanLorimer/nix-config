local api = vim.api
local bmap = require 'utils'.buf_map

local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }",
  group = yankGrp,
})

api.nvim_create_autocmd(
  "FileType",
  { pattern = { "haskell" }, command = [[setlocal commentstring=--\ %s]] }
)

local function set_agda_mappings()
  bmap('', '<leader>a', ':CornelisLoad<CR>')
  bmap('', '<leader>r', ':CornelisRefine<CR>')
  bmap('', '<leader>d', ':CornelisAuto<CR>')
  bmap('', '<leader>c', ':CornelisMakeCase<CR>')
  bmap('', '<leader>t', ':CornelisTypeContext<CR>')
  bmap('', '<leader>s', ':CornelisSolve<CR>')
  bmap('', '<leader>j', ':CornelisNextGoal<CR>')
  bmap('', '<leader>k', ':CornelisPrevGoal<CR>')
  bmap('', '<leader>n', ':CornelisNormalize<CR>')
  bmap('i', '\\step', "≡⟨ ? ⟩<CR>?")
  bmap('i', '\\beg', 'begin<CR>?<CR>≡⟨ ? ⟩<CR>?<CR>∎<Esc>V4k>><Esc>j^')
end

api.nvim_create_autocmd(
  { "BufEnter", "BufRead", "BufNewFile" },
  {
    pattern = "*.agda",
    callback = set_agda_mappings
  }
)
