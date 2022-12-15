local lsp_status = require('lsp-status')
lsp_status.register_progress()

local lsp = vim.lsp
local api = vim.api

-- LSP
lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
  lsp.diagnostic.on_publish_diagnostics, {
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
  local function buf_set_keymap(...) api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', '<leader>sa', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>sdc', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>sdf', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>sh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>si', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>ss', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>srn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>srf', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>sk', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<leader>sj', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap("n", "<leader>sf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)

  buf_set_keymap("n", "<leader>sl", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  buf_set_keymap("n", "<leader>sq", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts)
  buf_set_keymap("n", "<leader>si", "<cmd>LspInfo<CR>", opts)

  -- Setup hover diagnostic on hover
  local lsp_document_show_line_diagnostics = api.nvim_create_augroup("lsp_document_show_line_diagnostics",
    { clear = true })
  api.nvim_create_autocmd(
    "CursorHold",
    {
      pattern = "<buffer>",
      callback = function() vim.diagnostic.open_float(0, { scope = "line" }) end,
      group = lsp_document_show_line_diagnostics
    }
  )
  api.nvim_create_autocmd(
    "CursorMoved",
    {
      pattern = "<buffer>",
      callback = lsp.buf.clear_references,
      group = lsp_document_show_line_diagnostics
    }
  )

  if client.name == "rnix" then
    client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
  end

  -- Setup autoformat on save
  if client.server_capabilities.documentFormattingProvider then
    local lsp_format_on_save = api.nvim_create_augroup("lsp_format_on_save",
      { clear = true })
    api.nvim_create_autocmd('BufWritePre', {
      pattern = '<buffer>',
      group = lsp_format_on_save,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {
  tsserver = {},
  rnix = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        }
      }
    }
  },
  purescriptls = {},
  sumneko_lua = {},
  jsonls = {},
  cssls = {},
  eslint = {},
  html = {},
  terraformls = {},
  elixirls = {
    cmd = { "elixir-ls" },
  },
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
local client_capabilities = lsp.protocol.make_client_capabilities()
for k, v in pairs(lsp_status.capabilities) do client_capabilities[k] = v end
local capabilities = cmp_lsp.default_capabilities(client_capabilities)

-- Setup semantic highlight groups
vim.cmd [[highlight link LspSemantic_type Include]] -- Type constructors
vim.cmd [[highlight link LspSemantic_function Identifier]] -- Functions names
vim.cmd [[highlight link LspSemantic_enumMember Number]] -- Data constructors
vim.cmd [[highlight LspSemantic_variable guifg=gray]] -- Bound variables
vim.cmd [[highlight link LspSemantic_keyword Structure]] -- Keywords
vim.cmd [[highlight link LspSemantic_namespace Identifier]] -- Explicit namespaces
vim.cmd [[highlight link LspSemantic_postulate Define]] -- Postulates
vim.cmd [[highlight link LspSemantic_module Identifier]] -- Module identifiers

-- Setup server configs
for server, settings in pairs(servers) do
  local setup_args = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  for k, v in pairs(settings) do setup_args[k] = v end
  nvim_lsp[server].setup(setup_args)
end
