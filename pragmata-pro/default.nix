{
  runCommand,
  requireFile,
  unzip,
  grub2,
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

  console =
    runCommand "pragmata-pro-console-${version}"
    {
      outputHashMode = "recursive";
      outputHashAlgo = "sha256";
      outputHash = "Cxfs4RYMMMSvnVKNw8rs2dCHF3kLD1gfoUMJxO2bNnc=";
      src = requireFile {
        url = "https://fsd.it/my-account/downloads/";
        name = "PragmataPro${version}.zip";
        sha256 = "0yg2gljyqzlnj1mkx6qn5xzp02l8d98hla979gklnlmxm4vzzbsc";
      };
      buildInputs = [unzip];
    } ''
      unzip $src
      console_font_path=$out/share/fonts/consolefont/pragmatapro
      mkdir -p $console_font_path
      ${grub2}/bin/grub-mkfont -v -s 32 --range=0x0000-0x0241,0x2190-0x21FF,0x2500-0x259f ./PragmataPro0.830/PragmataPro_Mono_R_0830.ttf -o $console_font_path/ppr32.pf2
    '';
}
