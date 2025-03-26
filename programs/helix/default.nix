{
  colorscheme,
  pkgs,
  helix,
  scls,
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
      svelteserver = {
        command = "${pkgs.svelte-language-server}/bin/svelteserver";
        args = ["--stdio"];
      };
      scls = {
        command = "${scls}/bin/simple-completion-language-server";
        config = {
          max_completion_items = 3; # set max completion results len for each group: words, snippets, unicode-input
          feature_words = false; # enable completion by word
          feature_snippets = false; # enable snippets
          snippets_first = true; # completions will return before snippets by default
          snippets_inline_by_word_tail = false; # suggest snippets by WORD tail, for example text `xsq|` become `x^2|` when snippet `sq` has body `^2`
          feature_unicode_input = true; # enable "unicode input"
          feature_paths = true; # enable path completion
          feature_citations = false; # enable citation completion (only on `citation` feature enabled)
        };
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
      {
        name = "svelte";
        auto-format = false;
        language-servers = ["svelteserver"];
        # formatter = { command = "prettier", args = ["--parser", "html"]}
      }
      {
        name = "lean";
        scope = "source.lean";
        injection-regex = "lean";
        file-types = ["lean"];
        roots = ["lakefile.lean"];
        comment-token = "--";
        block-comment-tokens = {
          start = "/-";
          end = "-/";
        };
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        rulers = [101];
        text-width = 100;
        language-servers = ["lean" "scls"];
      }
    ];
  };

  settings = {
    theme = "zenwritten";
    editor = {
      trim-trailing-whitespace = true;
      trim-final-newlines = true;
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
      end-of-line-diagnostics = "hint";
      inline-diagnostics.cursor-line = "error";
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
      normal."C-f" = let
        gitBlameZellij = pkgs.writeShellScriptBin "git-blame-zellij" ''
          if [[ -v ZELLIJ ]]; then
            zellij action new-pane -- jj file annotate $1
          else
            echo "Not in a zellij session, this command opens commit annotations in a separate pane"
          fi
        '';
      in {
        l = ":sh git blame %{buffer_name} -L %{cursor_line}";
        L = ":sh ${gitBlameZellij}/bin/git-blame-zellij %{buffer_name}";
        b = ":sh gh browse '%{buffer_name}:%{cursor_line}' -c";
      };
    };
  };
  themes = {
    zenwritten = (import ./themes/zenwritten.nix) {inherit colorscheme;};
  };
}
