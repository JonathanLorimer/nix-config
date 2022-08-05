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
      rev = "e4def19944485787f5172bb952f8d46755999688";
      sha256 = "0xpxqhmm5a4gjd8s1ixxswd3vmkngy5nll81zqfn1kd936a2dja7";
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
