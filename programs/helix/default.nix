{
  colorscheme,
  pkgs,
}: {
  enable = true;
  defaultEditor = true;
  languages = {
    language = [
      {
        name = "nix";
        formatter = {
          command = "alejandra";
        };
        auto-format = true;
      }
      {
        name = "typescript";
        formatter = {
          command = "${pkgs.nodePackages_latest.prettier}/bin/prettier";
          args = ["--parser" "typescript"];
        };
        auto-format = true;
      }
    ];
  };
  settings = {
    theme = "zenwritten";
    editor = {
      idle-timeout = 50;
      completion-timeout = 50;
      completion-trigger-len = 0;
      gutters = ["spacer" "diagnostics" "line-numbers" "spacer" "diff"];
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
        s = "rename_symbol";
        r = "goto_reference";
        f = ":format";
        d = "goto_definition";
      };
    };
  };
  themes = {
    zenwritten = (import ./themes/zenwritten.nix) {inherit colorscheme;};
  };
}
