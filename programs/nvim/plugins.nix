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
  idris2-vim = pkgs.vimUtils.buildVimPlugin {
    name = "idris2-vim";
    src = pkgs.fetchFromGitHub {
      owner = "edwinb";
      repo = "idris2-vim";
      rev = "099129e08c89d9526ad092b7980afa355ddaa24c";
      sha256 = "1gip64ni2wdd5v4crl64f20pbrx24dmr3ci7w5c9da9hs85x1p29";
    };
  };
  vim-startuptime = pkgs.vimUtils.buildVimPlugin {
    name = "vim-startuptime";
    src = pkgs.fetchFromGitHub {
      owner = "dstein64";
      repo = "vim-startuptime";
      rev = "37ab78eb837e3004e3cfb3a8e5ed8f8740f27f13";
      sha256 = "0x3h47hdbg2gp0ahf0ixkj3nks7qbnm25bmd7hq9k3c7b6912b5a";
    };
  };
}
