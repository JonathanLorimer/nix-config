{buildVimPlugin, fetchFromGitHub}:
{
  vim-airline-themes = buildVimPlugin {
    name = "custom-vim-airline-themes";
    src = fetchFromGitHub {
      owner = "jonathanlorimer";
      repo = "vim-airline-themes";
      rev = "9e6923763607f1874d904a8aea671f54f30c75dc";
      sha256 = "0f1fwa3rhbpwcncmkiw8qdlai3sn7q6fs3h3g0z01szih6rmkzjb";
    };
  };
  idris2-vim = buildVimPlugin {
    name = "idris2-vim";
    src = fetchFromGitHub {
      owner = "edwinb";
      repo = "idris2-vim";
      rev = "099129e08c89d9526ad092b7980afa355ddaa24c";
      sha256 = "1gip64ni2wdd5v4crl64f20pbrx24dmr3ci7w5c9da9hs85x1p29";
    };
  };
  yesod-routes = buildVimPlugin {
    name = "yesod-routes";
    src = fetchFromGitHub {
      owner = "5outh";
      repo = "yesod-routes.vim";
      rev = "e00eaafe22aa33e2cf4a67d83dad4bc8ccdebbc5";
      sha256 = "1pamk9qxdpqig876vlg822symyhy0lq5krhcfhmr3k9bac7cpwyn";
    };
  };
}
