{ pkgs, nord, term-env}:
{
  enable = true;
  settings = {
    shell = {
      program = "${pkgs.zsh}/bin/zsh";
      args = [ "-c"
        "echo; neofetch; echo; zsh"
      ];
    };
    env = {
      TERM = "alacritty";
      EDITOR = "nvim";
    } // term-env;
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
      primary.background = nord.base00;
      primary.foreground = nord.base04;
      cursor.text = nord.base00;
      cursor.cursor = nord.base04;
      normal = {
        black = nord.base01;
        red = nord.base08;
        green = nord.base0B;
        yellow = nord.base0A;
        blue = nord.base0D;
        magenta = nord.base0E;
        cyan = nord.base0C;
        white = nord.base05;
      };
      bright = {
        black = nord.base03;
        red = nord.base08;
        green = nord.base0B;
        yellow = nord.base0A;
        blue = nord.base0D;
        magenta = nord.base0E;
        cyan = nord.base0C;
        white = nord.base06;
      };
    };
    background_opacity = 0.8;
    selection.save_to_clipboard = true;
    cursor.style = "Block";
    cursor.unfocused_hollow = true;
    url.launcher.program = "brave";
  };
}

