require 'nvim-rooter'.setup({
  rooter_patterns = {
    -- Strong signal
    ".git", "flake.nix",

    -- Language specific
    "package.yaml", "*.cabal", "package.json", "Cargo.toml",

    -- Low signal
    "Makefile"
  },
  update_cwd = true,
  update_focuse_file = {
    enable = true,
    update_cwd = true
  }
})
