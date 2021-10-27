{buildVimPlugin, fetchFromGitHub}:
{
  nvim-colorizer = buildVimPlugin {
    name = "nvim-colorizer";
    src = fetchFromGitHub {
      owner = "norcalli";
      repo = "nvim-colorizer.lua";
      rev = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6";
      sha256 = "0gvqdfkqf6k9q46r0vcc3nqa6w45gsvp8j4kya1bvi24vhifg2p9";
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
  cmp-path = buildVimPlugin {
    name = "cmp-path";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-path";
      rev = "2b1d31fef79a4c0ff803f6230859faf76e4409f9";
      sha256 = "1l3lyzgwlr7drxzig01by99vrgi7flvrnln3dmy14pg2x56lsbf3";
    };
  };
  cmp-buffer = buildVimPlugin {
    name = "cmp-buffer";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-buffer";
      rev = "5dde5430757696be4169ad409210cf5088554ed6";
      sha256 = "0fdywbv4b0z1kjnkx9vxzvc4cvjyp9mnyv4xi14zndwjgf1gmcwl";
    };
  };
  luatab-nvim = buildVimPlugin {
    name = "luatab-nvim";
    preConfigure = ''
      rm Makefile
    '';
    src = fetchFromGitHub {
      owner = "alvarosevilla95";
      repo = "luatab.nvim";
      rev = "da6a8f709c2a9c133d232aa21147bcf25445a89d";
      sha256 = "13w4ryqsl3lxxxcrb2dyc0h9kql4cmx0hbhxingrc1cncwgldnj9";
    };
  };
  zenbones-nvim = buildVimPlugin {
    name = "zenbones-nvim";
    preConfigure = ''
      rm makefile
    '';
    patches = [ ./patches/0001-make-types-bold.patch ];
    src = fetchFromGitHub {
      owner = "JonathanLorimer";
      repo = "zenbones.nvim";
      rev = "cc4abbb091043c7f80de0bd01134b054517debeb";
      sha256 = "1xhwc4500gzy87p9d4nzc9bd4lvg904m4rc9vrzh6zym7x43200c";
    };
  };
}
