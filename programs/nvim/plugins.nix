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
}
