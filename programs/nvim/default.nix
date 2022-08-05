{pkgs, cornelis-vim}:
let
  vimPluginsOverrides = import ./plugins.nix {
    buildVimPlugin = pkgs.vimUtils.buildVimPlugin;
    inherit (pkgs) fetchFromGitHub stack;

  };
in
{
  enable = true;
  extraConfig = builtins.readFile ./init.vim;
  plugins = with pkgs.vimPlugins // vimPluginsOverrides ; [

    # Utils
    venn-nvim
    comment-nvim
    goyo-vim
    vim-surround

    # Navigation
    nvim-tree-lua
    telescope-nvim
    plenary-nvim                # required by telescope
    popup-nvim                  # required by telescope
    telescope-fzf-native-nvim   # required by telescope
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
    nvim-colorizer-lua
    luatab-nvim

    # Git
    gitsigns-nvim

    # LSP
    lsp-status-nvim
    nvim-lspconfig
    luasnip
    fidget-nvim

    # Completion
    nvim-cmp
    cmp-buffer
    cmp-nvim-lsp
    cmp-path
    lspkind-nvim

    # Language Support
    playground
    nvim-treesitter
    vimtex
    haskell-vim
    yesod-routes
    nui-nvim # required for idris2-nvim
    idris2-nvim
    vim-textobj-user
    nvim-hs-vim
    dhall-vim
    purescript-vim
    cornelis-vim
  ];
}

