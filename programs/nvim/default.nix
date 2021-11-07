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
    # Utils
    kommentary
    goyo-vim
    vim-surround

    # Navigation
    nvim-tree-lua
    telescope-nvim
    plenary-nvim    # required by telescope
    popup-nvim      # required by telescope
    lightspeed-nvim
    {
      plugin = vim-rooter;
      config = ''
        let g:rooter_patterns = ['Makefile', 'package.yaml', 'package.json', '.git', 'src']
      '';
    }

    # Search
    todo-comments-nvim
    {
      plugin = vim-cool;
      config = ''
        let g:CoolTotalMatches = 1
      '';
    }

    # Themeing
    lush-nvim
    zenbones-nvim
    nord-nvim
    galaxyline-nvim
    nvim-web-devicons
    nvim-colorizer
    luatab-nvim

    # Git
    gitsigns-nvim

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
    playground
    nvim-treesitter
    haskell-vim
    yesod-routes
    idris2-vim
    agda-nvim
  ];
}

