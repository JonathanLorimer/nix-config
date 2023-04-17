{colorscheme}: {
  enable = true;
  settings = {
    simplified_ui = true;
    pane_frames = false;
    theme = "default";
    themes = {
      default = with colorscheme; {
        fg = base06;
        bg = base00;
        black = base0F;
        red = base08;
        green = base0B;
        yellow = base0A;
        blue = base0D;
        magenta = base0E;
        cyan = base0C;
        white = base07;
        orange = base09;
      };
    };
  };
}
