{stack, buildVimPlugin, fetchFromGitHub}:
{
  yesod-routes = buildVimPlugin {
    name = "yesod-routes";
    src = fetchFromGitHub {
      owner = "5outh";
      repo = "yesod-routes.vim";
      rev = "e00eaafe22aa33e2cf4a67d83dad4bc8ccdebbc5";
      sha256 = "1pamk9qxdpqig876vlg822symyhy0lq5krhcfhmr3k9bac7cpwyn";
    };
  };
  zenbones-nvim = buildVimPlugin {
    name = "zenbones-nvim";
    preConfigure = ''
      rm makefile
    '';
    patches = [ ./patches/0001-make-types-bold.patch ];
    src = fetchFromGitHub {
      owner = "mcchrish";
      repo = "zenbones.nvim";
      rev = "e2ac0557a3df217e5d82b7e580af75c244602a33";
      sha256 = "0i6s608gq08sbqk8hmz8879lfz8j489v333qr9cnr5d4d43nnwpb";
    };
  };
  idris2-nvim = buildVimPlugin {
    name = "idris2-nvim";
    src = fetchFromGitHub {
      owner = "ShinKage";
      repo = "idris2-nvim";
      rev = "757c5d1c99c9449f6a139d6303261f522ace46e2";
      sha256 = "0iiy0x37j0h1h3mjklgpaznva6krvsk7353ymjywq68x4spym806";
    };
  };
}
