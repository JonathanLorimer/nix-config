{
  colorscheme,
  default-font,
  pkgs,
}: {
  enable = true;
  enableZshIntegration = true;
  themes.personal-theme = with colorscheme; {
    background = base00;
    cursor-color = base06;
    foreground = base06;
    palette = [
      "0=${base01}"
      "1=${base08}"
      "2=${base0B}"
      "3=${base0A}"
      "4=${base0D}"
      "5=${base0E}"
      "6=${base0C}"
      "7=${base05}"
      "8=${base03}"
      "9=${base08}"
      "10=${base0B}"
      "11=${base0A}"
      "12=${base0D}"
      "13=${base0E}"
      "14=${base0C}"
      "15=${base06}"
    ];
    selection-background = base06;
    selection-foreground = base00;
  };
  settings = {
    theme = "personal-theme";
    font-size = 16;
    font-family = default-font;
    background-opacity = 0.87;
    window-padding-x = 4;
    window-padding-y = 4;
    window-decoration = false;
    initial-command = "${pkgs.zsh}/bin/zsh -c echo; neofetch; echo; zsh";
    shell-integration-features = ["no-cursor"];
    command = "${pkgs.zsh}/bin/zsh";
    cursor-style = "block";
    term = "ghostty";
  };
}
