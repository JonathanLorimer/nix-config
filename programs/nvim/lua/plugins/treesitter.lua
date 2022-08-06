local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.agda = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-agda",
    files = {"src/parser.c", "src/scanner.cc"}
  }
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"nix", "typescript", "css", "lua", "hcl", "json", "tsx", "yaml", "agda", "haskell", "rust"},
  highlight = { enable = true },
}
