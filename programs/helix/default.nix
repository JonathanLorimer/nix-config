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
      auto-pairs = false;
      smart-tab.enable = false;
      idle-timeout = 200;
      completion-timeout = 200;
      completion-trigger-len = 1;
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
      normal = {
        "{" = "goto_prev_paragraph";
        "}" = "goto_next_paragraph";
        "C-;" = "flip_selections";
      };
      select = {
        "C-;" = "flip_selections";
      };
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
      normal."C-j" = {
        s = "save_selection";
        l = "jump_forward";
        h = "jump_backward";
        j = "jumplist_picker";
      };
    };
  };
  themes = {
    zenwritten = (import ./themes/zenwritten.nix) {inherit colorscheme;};
  };
}
