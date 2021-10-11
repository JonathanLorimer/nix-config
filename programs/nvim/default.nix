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
    vim-grammarous
    { # Description: helps determine the root of the project
      plugin = vim-rooter;
      config = ''
        let g:rooter_patterns = ['Makefile', 'package.yaml', 'package.json', '.git', 'src']
      '';
    }
    vim-surround
    vim-vsnip
    vim-vsnip-integ

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
    { plugin = vim-sneak;
      config = ''
        let g:sneak#label=1
        highlight Sneak guifg=#ECEFF4 guibg=#D08770 ctermfg=Black ctermbg=DarkRed
        highlight SneakScope guifg=#D08770 guibg=#EBCB8B ctermfg=DarkRed ctermbg=Yellow
      '';
    }

    # Themeing
    vim-airline
    vim-airline-themes
    nord-vim
    nvim-web-devicons
    nvim-colorizer

    # Git
    vim-fugitive
    vim-signify

    # LSP
    nvim-lspconfig
    { plugin = completion-nvim;
      config = ''
        let g:completion_enable_snippet = 'vim-vsnip'
        let g:completion_chain_complete_list = [
            \{'complete_items': ['lsp', 'snippet']},
            \{'complete_items':  ['path'], 'triggered_only': ['/']},
            \{'complete_items': ['buffers']},
            \{'mode': '<c-p>'},
            \{'mode': '<c-n>'}
        \]
        let g:completion_items_priority = {
            \'Function': 7,
            \'Snippet': 5,
            \'vim-vsnip': 5,
            \'File': 2,
            \'Folder': 1,
            \'Path': 1,
            \'Buffers': 0
        \}
      '';
    }
    completion-buffers

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

