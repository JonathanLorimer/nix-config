{
  runCommand,
  requireFile,
  unzip,
}: let
  version = "0.830";
in {
  patched =
    runCommand "pragmata-pro-patched-${version}"
    {
      outputHashMode = "recursive";
      outputHashAlgo = "sha256";
      outputHash = "3gtaBUipdV+5yQog1iREd+XOzpDKbMl0lwzMNFVv+Ks=";
      src = requireFile {
        url = "https://fsd.it/my-account/downloads/";
        name = "PragmataProPatched${version}.zip";
        sha256 = "0r6221r73df69cvdj66g9f5pbkyypncx4d2d627cnhfxr7czxfjd";
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
      outputHash = "NL8nPkmtTyqDhf0PrAbnwrmttN+IxVsDHvygprk0k+c=";
      src = requireFile {
        url = "https://fsd.it/my-account/downloads/";
        name = "PragmataPro${version}.zip";
        sha256 = "0yg2gljyqzlnj1mkx6qn5xzp02l8d98hla979gklnlmxm4vzzbsc";
      };
      buildInputs = [unzip];
    } ''
      unzip $src
      install_path=$out/share/fonts/truetype/pragmatapro
      mkdir -p $install_path
      find -name "PragmataPro*.ttf" -exec mv {} $install_path \;
    '';
}
