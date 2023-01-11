local util = require "formatter.util"

require("formatter").setup {
  logging = false,
  log_level = vim.log.levels.DEBUG,
  filetype = {
    javascriptreact = { require 'formatter.defaults.prettier' },
    javascript = { require 'formatter.defaults.prettier' },
    typescriptreact = { require 'formatter.defaults.prettier' },
    typescript = { require 'formatter.defaults.prettier' },
    json = { require 'formatter.defaults.prettier' },
    markdown = { require 'formatter.defaults.prettier' },
    html = { require 'formatter.defaults.prettier' },
    css = { require 'formatter.defaults.prettier' },
    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}


local api = vim.api

local format_on_save = api.nvim_create_augroup("format_on_save", { clear = true })

api.nvim_create_autocmd('BufWritePre', {
  pattern = '<buffer>',
  group = format_on_save,
  command = "FormatWrite"
})
