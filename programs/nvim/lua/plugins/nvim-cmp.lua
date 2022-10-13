local cmp = require'cmp'
local lspkind = require'lspkind'
-- local luasnip = require'luasnip'

-- local has_words_before = function()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end
--
-- https://github.com/hrsh7th/nvim-cmp/issues/156#issuecomment-916338617
local lspkind_comparator = function(conf)
  local lsp_types = require('cmp.types').lsp
  return function(entry1, entry2)
    if entry1.source.name ~= 'nvim_lsp' then
      if entry2.source.name == 'nvim_lsp' then
        return false
      else
        return nil
      end
    end
    local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
    local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

    local priority1 = conf.kind_priority[kind1] or 0
    local priority2 = conf.kind_priority[kind2] or 0
    if priority1 == priority2 then
      return nil
    end
    return priority2 < priority1
  end
end

local label_comparator = function(entry1, entry2)
  return entry1.completion_item.label < entry2.completion_item.label
end

cmp.setup({
  mapping = {
    ['<C-k>'] = cmp.mapping.scroll_docs(-4),
    ['<C-j>'] = cmp.mapping.scroll_docs(4),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    -- { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
  formatting = {
    format = lspkind.cmp_format(),
  },
  comparators = {
    lspkind_comparator({
      kind_priority = {
        Field = 11,
        Property = 11,
        Constant = 10,
        Enum = 10,
        EnumMember = 10,
        Event = 10,
        Function = 10,
        Method = 10,
        Operator = 10,
        Reference = 10,
        Struct = 10,
        Variable = 9,
        File = 8,
        Folder = 8,
        Class = 5,
        Color = 5,
        Module = 5,
        Keyword = 2,
        Constructor = 1,
        Interface = 1,
        Snippet = 0,
        Text = 1,
        TypeParameter = 1,
        Unit = 1,
        Value = 1,
      },
    }),
    label_comparator,
  },
})

vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
    pattern = "Cargo.toml",
    callback = function()
        cmp.setup.buffer({ sources = { { name = "crates" } } })
    end,
})
