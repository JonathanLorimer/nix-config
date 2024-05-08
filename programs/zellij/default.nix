{colorscheme}: {
  enable = true;
  settings = {
    ## TODO: Should look into setting up better keybindings, doing this from
    ## nix kinda sucks, which is why I have put this off for so long
    ## See: https://github.com/nix-community/home-manager/pull/4465

    keybinds = {
      unbind = "Ctrl q";
      shared = {
        "bind \"Ctrl k\"" = { "Quit ;" = []; };
      };
    };
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
