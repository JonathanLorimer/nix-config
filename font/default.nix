{usePragmata}: {
  default-font =
    if usePragmata
    then "PragmataPro Mono Liga"
    else "Iosevka Term";

  module = {
    pkgs,
    lib,
    config,
    ...
  }: let
    # pragmata-pro-console = (pkgs.callPackage ./pragmata-pro.nix {}).console;
    pragmata-pro = (pkgs.callPackage ./pragmata-pro.nix {}).unpatched;
  in {
    fonts.packages =
      [
        pkgs.font-awesome
      ]
      ++ pkgs.lib.optionals usePragmata [pragmata-pro];

    # boot.loader.grub.font =
    #   if usePragmata
    #   then "${pragmata-pro-console}/share/fonts/consolefont/pragmatapro/ppr32.pf2"
    #   else
    #     pkgs.runCommand "dejavu-console" {} ''
    #       console_font_path=$out/share/fonts/consolefont/dejavu
    #       mkdir -p $console_font_path
    #       ${pkgs.grub2}/bin/grub-mkfont -v -s 32 --range=0x0000-0x0241,0x2190-0x21FF,0x2500-0x259f ${pkgs.dejavu_fonts}/share/fonts/truetype/DejaVuSans.ttf -o $console_font_path/ppr32.pf2
    #     '';
    # boot.loader.grub.fontSize = 32;
  };
}
