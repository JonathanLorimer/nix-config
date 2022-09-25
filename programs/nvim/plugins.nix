{stack, buildVimPlugin, fetchFromGitHub}:
{
  zenbones-nvim = buildVimPlugin {
    name = "zenbones-nvim";
    preConfigure = ''
      rm makefile
    '';
    # patches = [ ./patches/0001-make-types-bold.patch ];
    src = fetchFromGitHub {
      owner = "mcchrish";
      repo = "zenbones.nvim";
      rev = "e608ef16b1a636e653a471f36c869193ed4b5e9d";
      sha256 = "sha256-VooPRuj64o92sPs1pqqYRazPYteX0HEsEQ9Re8YI6oE=";
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
