{
  stack,
  buildVimPlugin,
  fetchFromGitHub,
  lib,
}: {
  zenbones-nvim = buildVimPlugin {
    name = "zenbones-nvim";
    preConfigure = ''
      rm makefile
    '';
    src = fetchFromGitHub {
      owner = "mcchrish";
      repo = "zenbones.nvim";
      rev = "v4.0.2";
      sha256 = "sha256-KVN/Xbo92ob72Ix3jw6D8GDDX7aNBMsj90bm2YA5TCo="; 
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
  spaceless-nvim = buildVimPlugin {
    name = "spacless.nvim";
    src = fetchFromGitHub {
      owner = "lewis6991";
      repo = "spaceless.nvim";
      rev = "4012c778cf8973379cc4e7e52d2260b15d390462";
      sha256 = "1d677f8v20k1fw4gs1a9zbhfjgn142i6gnjlf89jmv00fyj1l9ji";
    };
  };
  tabnine-nvim = buildVimPlugin {
    name = "tabnine-nvim";
    src = fetchFromGitHub {
      owner = "JonathanLorimer";
      repo = "tabnine-nvim";
      rev = "6db805376b0b17985b41705005f9e2f4af1a2f71";
      sha256 = "sha256-uCeH73uliFXrc8c66jKRsRDo5+xPP/m+J3Nayj4n2r0=";
      fetchSubmodules = true;
    };
  };
}
