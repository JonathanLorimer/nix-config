{stack, buildVimPlugin, fetchFromGitHub}:
{
  zenbones-nvim = buildVimPlugin {
    name = "zenbones-nvim";
    preConfigure = ''
      rm makefile
    '';
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
  nvim-rooter = buildVimPlugin {
    name = "nvim-rooter";
    src = fetchFromGitHub {
      owner = "notjedi";
      repo = "nvim-rooter.lua";
      rev = "833e6a37fafb9b2acb6228b9005c680face2a20f";
      sha256 = "1x1bl1iijd1x5292yl2ngr0h1f0hrv82pvad9ydk4w9pzw7ljkzl";
    };
  };
  barbar-nvim = buildVimPlugin {
    name = "barbar-nvim";
    src = fetchFromGitHub {
      owner = "romgrk";
      repo = "barbar.nvim";
      rev = "61424a6211431a42458bc755b3e7e982e671c438";
      sha256 = "1xg7wm3prq2vj0jg2knb96lc7mlh7l6fw6c23s0i9vqrbz4b8jr2";
    };
  };
}
