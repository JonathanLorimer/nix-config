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
