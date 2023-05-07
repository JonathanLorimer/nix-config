{colorscheme, pkgs}: {
  package = pkgs.swaylock-effects;
  settings = {
    screenshots = true;
    clock = true;
    indicator = true;
    show-failed-attempts = true;
    ignore-empty-password = true;
    effect-blur = "7x5";
    effect-vignette = "0.6:0.6";
    ring-color = colorscheme.base0D;
    ring-ver-color = colorscheme.base0B;
    ring-wrong-color = colorscheme.base08;
    key-hl-color = colorscheme.base0A;
    line-color = "00000000";
    line-ver-color = "00000000";
    line-wrong-color = "00000000";
    inside-color = "00000000";
    inside-ver-color = "00000000";
    inside-wrong-color = "00000000";
    separator-color = "00000000";
    text-color = colorscheme.base04;
  };
}
