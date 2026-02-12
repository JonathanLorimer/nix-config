{
  runCommand,
  requireFile,
  unzip,
  grub2,
}: let
  pragmataParams = {
    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    src = requireFile {
      url = "https://fsd.it/my-account/downloads/";
      name = "PragmataPro.zip";
      sha256 = "sha256-dwQA6dTz1A/oiTr5rh94T2/60kH8QYkSjE08RhX7dyc=";
    };
    buildInputs = [unzip];
  };
in {
  unpatched =
    runCommand "pragmata-pro" (pragmataParams
      // {
        buildInputs = [unzip];
        outputHash = "sha256-OYqn4ia+4WvUjgW+0H52BqonVwCB9Zzb8cn15fMO0GY=";
      })
    ''
      unzip $src
      install_path=$out/share/fonts/truetype/pragmatapro
      mkdir -p $install_path
      find -name "PragmataPro*.ttf" -exec mv {} $install_path \;
    '';

  console =
    runCommand "pragmata-pro-console" (pragmataParams
      // {
        buildInputs = [unzip];
        outputHash = "sha256-ZSKbjPSDdLC2ywENoU0pLlIE2Z1vit+kjJyU07Nn4/8=";
      })
    ''
      unzip $src
      console_font_path=$out/share/fonts/consolefont/pragmatapro
      mkdir -p $console_font_path
      fontpath=$(find -name "PragmataPro_Mono_R_*.ttf" -print -quit)
      ${grub2}/bin/grub-mkfont -v -s 32 --range=0x0000-0x0241,0x2190-0x21FF,0x2500-0x259f $fontpath -o $console_font_path/ppr32.pf2
    '';
}
