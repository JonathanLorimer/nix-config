{ runCommand, requireFile, unzip }:

let
  pname = "pragmata-pro-patched-${version}";
  version = "0.829";
in
runCommand pname
  rec {
    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "HrY1lv3BUej9dgoG03sSK0Bdjr6tYQFVSu8DJIpobJM=";
    src = requireFile rec {
      url = "https://fsd.it/my-account/downloads/";
      name = "PragmataProPatched${version}.zip";
      sha256 = "1530qw3q2bmxlgqz2qfqwillwi58s2fnmr0fn54wbjxcmrz450hg";
    };
    buildInputs = [ unzip ];
  } ''
    unzip $src
    install_path=$out/share/fonts/truetype/pragmatapro
    mkdir -p $install_path
    find -name "PragmataPro*.ttf" -exec mv {} $install_path \;
  ''
