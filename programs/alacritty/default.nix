{ pkgs, nord }:
{
  enable = true;
  settings = {
    shell = {
      program = "${pkgs.zsh}/bin/zsh";
      args = [ "-c"
        "echo; neofetch; echo; zsh"
      ];
    };
    env.TERM = "alacritty";
    env.EDITOR = "nvim";
    window = {
      padding.x = 4;
      padding.y = 4;
      gtk_theme_variant = "Dark";
    };
    scrolling.history = 10000;
    font.normal = {
      family = "PragmataPro Mono";
      style = "Regular";
    };
    font.bold = {
      family = "PragmataPro Mono";
      style = "Bold";
    };
    font.italic = {
      family = "PragmataPro Mono";
      style = "Italic";
    };
    font.bold_italic = {
      family = "PragmataPro Mono";
      style = "Bold Italic";
    };
    font.size = 12.0;
    colors = {
      primary.background = nord.background;
      primary.foreground = nord.foreground;
      cursor.text = nord.cursorText;
      cursor.cursor = nord.cursor;
      normal = {
        black = nord.colour0;
        red = nord.colour1;
        green = nord.colour2;
        yellow = nord.colour3;
        blue = nord.colour4;
        magenta = nord.colour5;
        cyan = nord.colour6;
        white = nord.colour7;
      };
      bright = {
        black = nord.colour8;
        red = nord.colour9;
        green = nord.colour10;
        yellow = nord.colour11;
        blue = nord.colour12;
        magenta = nord.colour13;
        cyan = nord.colour14;
        white = nord.colour15;
      };
    };
    background_opacity = 0.8;
    selection.save_to_clipboard = true;
    cursor.style = "Block";
    cursor.unfocused_hollow = true;
    url.launcher.program = "brave";
  };
}

