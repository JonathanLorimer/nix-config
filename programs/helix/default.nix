{
  colorscheme,
  pkgs,
  helix,
}: {
  enable = true;
  package = helix;
  defaultEditor = true;
  languages = {
    language-server = {
      vtsls = {
        command = "vtsls";
        args = ["--stdio"];
      };
    };
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
        language-servers = [
          {name = "vtsls";}
        ];
        auto-format = true;
      }
      {
        name = "tsx";
        formatter = {
          command = "${pkgs.nodePackages_latest.prettier}/bin/prettier";
          args = ["--parser" "typescript"];
        };
        language-servers = [
          {name = "vtsls";}
        ];
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
        g.k = "goto_prev_change";
        g.j = "goto_next_change";
        "{" = "goto_prev_paragraph";
        "}" = "goto_next_paragraph";
        "C-;" = "flip_selections";
      };
      select = {
        "C-;" = "flip_selections";
      };
      normal."C-t" = {
        e = "expand_selection";
        s = "shrink_selection";
        k = "select_prev_sibling";
        j = "select_next_sibling";
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
      normal."C-x" = {
        b = ":sh zellij action new-pane -- git blame %{filename:git_rel}";
      };
    };
  };
  themes = {
    zenwritten = (import ./themes/zenwritten.nix) {inherit colorscheme;};
  };
}
