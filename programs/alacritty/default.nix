{
  pkgs,
  colorscheme,
  term-env,
  default-font,
}: {
  enable = true;
  settings = {
    shell = {
      program = "${pkgs.zsh}/bin/zsh";
      args = [
        "-c"
        "echo; neofetch; echo; zsh"
      ];
    };
    env =
      {
        TERM = "alacritty";
        EDITOR = "nvim";
      }
      // term-env;
    window = {
      opacity = 0.87;
      padding.x = 4;
      padding.y = 4;
      decorations_theme_variant = "Dark";
    };
    scrolling.history = 10000;
    font.normal = {
      family = default-font;
      style = "Regular";
    };
    font.bold = {
      family = default-font;
      style = "Bold";
    };
    font.italic = {
      family = default-font;
      style = "Italic";
    };
    font.bold_italic = {
      family = default-font;
      style = "Bold Italic";
    };
    font.size = 16.0;
    colors = {
      primary.background = colorscheme.base00;
      primary.foreground = colorscheme.base06;
      cursor.text = colorscheme.base00;
      cursor.cursor = colorscheme.base06;
      normal = {
        black = colorscheme.base01;
        red = colorscheme.base08;
        green = colorscheme.base0B;
        yellow = colorscheme.base0A;
        blue = colorscheme.base0D;
        magenta = colorscheme.base0E;
        cyan = colorscheme.base0C;
        white = colorscheme.base05;
      };
      bright = {
        black = colorscheme.base03;
        red = colorscheme.base08;
        green = colorscheme.base0B;
        yellow = colorscheme.base0A;
        blue = colorscheme.base0D;
        magenta = colorscheme.base0E;
        cyan = colorscheme.base0C;
        white = colorscheme.base06;
      };
    };
    selection.save_to_clipboard = true;
    cursor.style = "Block";
    cursor.unfocused_hollow = true;
    url.launcher.program = "firefox";
  };
}
