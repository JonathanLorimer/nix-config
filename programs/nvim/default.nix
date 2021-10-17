{pkgs}:
let
  vimPluginsOverrides = import ./plugins.nix {
    buildVimPlugin = pkgs.vimUtils.buildVimPlugin;
    inherit (pkgs) fetchFromGitHub;
  };
in
{
  enable = true;
  extraConfig = builtins.readFile ./init.vim;
  plugins = with pkgs.vimPlugins // vimPluginsOverrides ; [

    # General
    syntastic
    kommentary
    goyo-vim

    vim-surround

    # Navigation
    nvim-tree-lua
    telescope-nvim
    plenary-nvim    # required by telescope
    popup-nvim      # required by telescope

    # Search
    { # Description: disables search highlighting when done, re-enables it
      # when you go back to searching.
      plugin = vim-cool;
      config = ''
        let g:CoolTotalMatches = 1
      '';
    }

    # Themeing
    galaxyline-nvim
    nord-vim
    nvim-web-devicons
    nvim-colorizer
    luatab-nvim

    # Git
    vim-fugitive
    vim-signify

    # LSP
    lsp-status-nvim
    nvim-lspconfig

    # Completion
    nvim-cmp
    cmp-buffer
    cmp-nvim-lsp
    cmp-path
    lspkind-nvim

    # Language Support
    dhall-vim
    purescript-vim
    vim-markdown
    vim-nix
    haskell-vim
    yesod-routes
    idris2-vim
    typescript-vim
    vim-tsx
  ];
}

