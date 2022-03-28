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
      owner = "JonathanLorimer";
      repo = "zenbones.nvim";
      rev = "cc4abbb091043c7f80de0bd01134b054517debeb";
      sha256 = "1xhwc4500gzy87p9d4nzc9bd4lvg904m4rc9vrzh6zym7x43200c";
    };
  };
}
