local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.agda = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-agda",
    files = {"src/parser.c", "src/scanner.cc"}
  }
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"nix", "typescript", "css", "lua", "hcl", "json", "tsx", "yaml", "agda", "haskell"},
  highlight = { enable = true },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}
