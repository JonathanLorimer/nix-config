local lsp_status = require('lsp-status')
lsp_status.register_progress()

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
  buf_set_keymap('n', '<leader>sk', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<leader>sj', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>sq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>sf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- Setup hover augroup
  vim.api.nvim_exec([[
    augroup lsp_document_show_line_diagnostics
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.diagnostic.open_float(0, {scope = "line"})
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
  ]], false)
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {
  tsserver = {},
  rnix = {},
  rust_analyzer = {},
  purescriptls = {},
  hls = {
    settings = {
      languageServerHaskell = {
        formattingProvider = "fourmolu",
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
  },
}

-- Setup completion
local cmp_lsp = require('cmp_nvim_lsp')

-- Setup capabilities
local client_capabilities = vim.lsp.protocol.make_client_capabilities()
for k,v in pairs(lsp_status.capabilities) do client_capabilities[k] = v end
local capabilities = cmp_lsp.update_capabilities(client_capabilities)

-- Setup semantic highlight groups
vim.cmd [[highlight link LspSemantic_type Include]]   -- Type constructors
vim.cmd [[highlight link LspSemantic_function Identifier]] -- Functions names
vim.cmd [[highlight link LspSemantic_enumMember Number]]   -- Data constructors
vim.cmd [[highlight LspSemantic_variable guifg=gray]] -- Bound variables
vim.cmd [[highlight link LspSemantic_keyword Structure]]  -- Keywords
vim.cmd [[highlight link LspSemantic_namespace Identifier]] -- Explicit namespaces
vim.cmd [[highlight link LspSemantic_postulate Define]] -- Postulates
vim.cmd [[highlight link LspSemantic_module Identifier]] -- Module identifiers

 -- Setup server configs
for lsp, settings in pairs(servers) do
  local setup_args = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  for k,v in pairs(settings) do setup_args[k] = v end
  nvim_lsp[lsp].setup(setup_args)
end
