{ runCommand, requireFile, unzip }:

let
  pname = "pragmata-pro-${version}";
  version = "0.829";
in
runCommand pname
  rec {
    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "GG8id7kZMqyDCDyvJLNL1CUrlaLzzL70f/b8CXYQGXE=";
    src = requireFile rec {
      url = "https://fsd.it/my-account/downloads/";
      name = "PragmataPro${version}.zip";
      sha256 = "0dg7h80jaf58nzjbg2kipb3j3w6fz8z5cyi4fd6sx9qlkvq8nckr";
    };
    buildInputs = [ unzip ];
  } ''
    unzip $src
    install_path=$out/share/fonts/truetype/pragmatapro
    mkdir -p $install_path
    find -name "PragmataPro*.ttf" -exec mv {} $install_path \;
  ''
