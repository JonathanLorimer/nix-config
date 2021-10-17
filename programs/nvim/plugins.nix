{buildVimPlugin, fetchFromGitHub}:
{
  kommentary = buildVimPlugin {
    name = "kommentary";
    src = fetchFromGitHub {
      owner = "b3nj5m1n";
      repo = "kommentary";
      rev = "c2a9f34a11234e3478ff4133f0c03f895aafe30f";
      sha256 = "0jqy7zklmc242scacs66r2h6mjd49d5f3srrnjqgk28ylap0qq6i";
    };
  };
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
}
