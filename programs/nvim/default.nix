{
  pkgs,
  cornelis-vim,
}: let
  vimPluginsOverrides = import ./plugins.nix {
    buildVimPlugin = pkgs.vimUtils.buildVimPlugin;
    inherit (pkgs) fetchFromGitHub stack;
  };
in {
  enable = true;
  extraConfig = "lua require'init-homemanager'";
  plugins = with pkgs.vimPlugins // vimPluginsOverrides; [
    # Utils
    impatient-nvim
    venn-nvim
    comment-nvim
    vim-surround
    nvim-rooter
    spaceless-nvim

    # Navigation
    nvim-tree-lua
    telescope-nvim
    plenary-nvim # required by telescope
    popup-nvim # required by telescope
    telescope-fzf-native-nvim # required by telescope
    harpoon

    # Search
    todo-comments-nvim
    vim-cool

    # Themeing
    lush-nvim
    zenbones-nvim
    barbar-nvim
    nvim-web-devicons
    nvim-colorizer-lua

    # Git
    gitsigns-nvim

    # LSP
    lsp-status-nvim
    nvim-lspconfig
    fidget-nvim

    # Completion
    nvim-cmp
    cmp-buffer
    cmp-nvim-lsp
    cmp-path
    lspkind-nvim

    # Formatting
    formatter-nvim

    # Language Support
    nvim-treesitter.withAllGrammars
    vimtex
    vim-textobj-user
    nvim-hs-vim
    cornelis-vim
    dhall-vim
    purescript-vim
    crates-nvim
  ];
}
