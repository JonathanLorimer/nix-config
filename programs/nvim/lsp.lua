-- Snippets
vim.g.vsnip_snippet_dir = '~/.config/nixpkgs/programs/nvim/snippets'

-- Completion
local rt = function(codes)
    return vim.api.nvim_replace_termcodes(codes, true, true, true)
end

local call = vim.api.nvim_call_function

function tab_complete()
    if vim.fn.pumvisible() == 1 then
        return rt('<C-N>')
    elseif call('vsnip#available', {1}) == 1 then
        return rt('<Plug>(vsnip-expand-or-jump)')
    else
        return rt('<Tab>')
    end
end

function s_tab_complete()
    if vim.fn.pumvisible() == 1 then
        return rt('<C-P>')
    elseif call('vsnip#jumpable', {-1}) == 1 then
        return rt('<Plug>(vsnip-jump-prev)')
    else
        return rt('<S-Tab>')
    end
end

vim.lsp.protocol.CompletionItemKind = {
  Text = '',
  Function = 'λ',
  Variable = '',
  Module = '',
  Property = '',
  Keyword = '',
  Snippet = '﬌',
  VSnip = '﬌',
  File = '',
  Folder = '',
}

-- LSP
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- disable virtual text
    virtual_text = false,

    -- show signs
    signs = true,

    -- delay update diagnostics
    update_in_insert = false,
    underline = true,
  }
)
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', '<leader>sa','<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>sdc', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>sdf', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>sh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>si', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>ss', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>st', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>srn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>srf', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>sd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>sk', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<leader>sj', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>sq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>sf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.show_line_diagnostics then
    vim.api.nvim_exec([[
      augroup lsp_document_show_line_diagnostics
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {
  tsserver = {},
  rnix = {},
  hls = {
    languageServerHaskell = {
      formattingProvider = "ormolu",
      formatOnImportOn = true,
      completionSnippetOn = true,
      hlintOn = true,
      plugin = {
        tactics = {
          config = {
            features = "QrfgehpgNyy/HfrQngnPba/ErsvarUbyr/XabjaZbabvq"
          }
        }
      }
    }
  }
}

for lsp, settings in pairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    settings = settings
  }
end
