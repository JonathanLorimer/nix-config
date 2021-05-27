-- nvim-web-devicons
require'nvim-web-devicons'.setup { default = true; }
require'colorizer'.setup ({ '*'; }, { css = true; })
require'telescope'.setup({
  defaults = {
    prompt_prefix = "🔍 ",
    selection_caret = "👉 ",
    layout_strategy = "flex",
  };
})
require'kommentary.config'.configure_language("default", {
  prefer_single_line_comments = true,
  use_consistent_indentation = true,
  ignore_whitespace = true
})
