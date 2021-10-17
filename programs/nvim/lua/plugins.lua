require'nvim-web-devicons'.setup { default = true; }
require'colorizer'.setup ({ '*'; }, { css = true; })
require'kommentary.config'.configure_language("default", {
  prefer_single_line_comments = true,
  use_consistent_indentation = true,
  ignore_whitespace = true
})
vim.o.tabline = '%!v:lua.require\'luatab\'.tabline()'
