{ pkgs }:

{
  custom-vim-airline-themes = pkgs.vimUtils.buildVimPlugin {
    name = "custom-vim-airline-themes";
    src = pkgs.fetchFromGitHub {
      owner = "jonathanlorimer";
      repo = "vim-airline-themes";
      rev = "9e6923763607f1874d904a8aea671f54f30c75dc";
      sha256 = "0f1fwa3rhbpwcncmkiw8qdlai3sn7q6fs3h3g0z01szih6rmkzjb";
    };
  };

  vim-syntax-shakespeare = pkgs.vimUtils.buildVimPlugin {
    name = "vim-syntax-shakespeare";
    src = pkgs.fetchFromGitHub {
      owner = "pbrisbin";
      repo = "vim-syntax-shakespeare";
      rev = "2f4f61eae55b8f1319ce3a086baf9b5ab57743f3";
      sha256 = "0h79c3shzf08g7mckc7438vhfmxvzz2amzias92g5yn1xcj9gl5i";
    };
  };
}
