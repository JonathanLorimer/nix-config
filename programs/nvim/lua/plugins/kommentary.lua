require'kommentary.config'.configure_language("default", {
  prefer_single_line_comments = true,
  ignore_whitespace = true
})
require'kommentary.config'.configure_language("nix", {
  single_line_comment_string = "#",
})
require'kommentary.config'.configure_language("cabal", {
  single_line_comment_string = "--",
})
