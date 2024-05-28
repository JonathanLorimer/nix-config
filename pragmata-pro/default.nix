{
  runCommand,
  requireFile,
  unzip,
}: let
  version = "0.829";
in {
  patched =
    runCommand "pragmata-pro-patched-${version}"
    {
      outputHashMode = "recursive";
      outputHashAlgo = "sha256";
      outputHash = "ogGgX0/yMRO//K1ZgrOTMPMK06lokqByQR/BxL9MxYg=";
      src = requireFile {
        url = "https://fsd.it/my-account/downloads/";
        name = "PragmataProPatched${version}.zip";
        sha256 = "1pp7aymyjfi3dq7bc0n740qhgfb44dzz285j3lf8amfdwbpyr8vv";
      };
      buildInputs = [unzip];
    } ''
      unzip $src
      install_path=$out/share/fonts/truetype/pragmatapro
      mkdir -p $install_path
      find -name "PragmataPro*.ttf" -exec mv {} $install_path \;
    '';

  unpatched =
    runCommand "pragmata-pro-${version}"
    {
      outputHashMode = "recursive";
      outputHashAlgo = "sha256";
      outputHash = "GG8id7kZMqyDCDyvJLNL1CUrlaLzzL70f/b8CXYQGXE=";
      src = requireFile {
        url = "https://fsd.it/my-account/downloads/";
        name = "PragmataPro${version}.zip";
        sha256 = "0q9lyg7j8nfnl6z3nw0bb15whk1hk6h4hxkwa5fnbg62cw04jg2m";
      };
      buildInputs = [unzip];
    } ''
      unzip $src
      install_path=$out/share/fonts/truetype/pragmatapro
      mkdir -p $install_path
      find -name "PragmataPro*.ttf" -exec mv {} $install_path \;
    '';
}
