{ colorscheme }:
{
  enable = true;
  languages = {};
  settings = { 
    theme = "zenwritten";
    editor = {
      color-modes = true;
      line-number = "relative";
      cursor-shape = {
        insert = "bar"; 
        normal = "block";
        select = "underline";
      };
      statusline = {
        mode.normal = "N";
        mode.insert = "I";
        mode.select = "V";
      };
    };
    keys = {
      normal."C-l" = {
        j = "goto_next_diag";
        k = "goto_prev_diag";
        a = "code_action";
        h = "hover";
        r = "rename_symbol";
        f = ":format";
      };
    };
  };
  themes = {
    zenwritten = (import ./themes/zenwritten.nix) { inherit colorscheme; };
  };
}
