local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.agda = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-agda",
    files = { "src/parser.c", "src/scanner.cc" }
  }
}

vim.opt.runtimepath:append("$HOME/.local/share/nvim/site/parser/")
require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "nix", "typescript", "css", "lua", "json", "tsx", "haskell", "rust" },
  highlight = { enable = true },
  parser_install_dir = "$HOME/.local/share/nvim/site/parser/",
}
