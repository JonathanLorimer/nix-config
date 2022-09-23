local api = vim.api
local map = require'utils'.map

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
  map('', '<leader>a', ':CornelisLoad<CR>', true)
  map('', '<leader>r', ':CornelisRefine<CR>', true)
  map('', '<leader>d', ':CornelisAuto<CR>', true)
  map('', '<leader>c', ':CornelisMakeCase<CR>', true)
  map('', '<leader>t', ':CornelisTypeContext<CR>', true)
  map('', '<leader>s', ':CornelisSolve<CR>', true)
  map('', '<leader>j', ':CornelisNextGoal<CR>', true)
  map('', '<leader>k', ':CornelisPrevGoal<CR>', true)
  map('', '<leader>n', ':CornelisNormalize<CR>', true)
end

api.nvim_create_autocmd(
  {"BufEnter", "BufRead", "BufNewFile"},
  {
    pattern = "*.agda",
    callback = set_agda_mappings
  }
)
