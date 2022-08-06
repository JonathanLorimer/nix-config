{ pkgs, term-env, default-font }:
{
  enable = true;
  environment = {
    TERM = "kitty";
    EDITOR = "nvim";
  } // term-env;
  font.package = pkgs.pragmata-pro;
  font.name = "PragmataPro Mono Liga";
  font.size = 16;
  theme = "Nord";
  settings.background_opacity = "0.85";
  settings.cursor_blink_interval = 0;
  settings.window_padding_width = "0.5pt";

}
