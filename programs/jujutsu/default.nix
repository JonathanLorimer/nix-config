{
  delta,
  meld,
}: let
  email = "jonathan_lorimer@mac.com";
in {
  enable = true;
  settings = {
    user = {
      name = "Jonathan Lorimer";
      email = email;
    };

    signing = {
      sign-all = true;
      backend = "gpg";
      key = email;
    };

    template-aliases = {
      "format_timestamp(timestamp)" = "timestamp.ago()";
      "format_short_signature(signature)" = "signature.name()";
    };

    revsets = {
      log = "@ | bases | working_lineage | base_branches | base_heads | base_roots";
    };

    revset-aliases = {
      bases = "present(branches(base)) | trunk()";
      working_lineage = "bases::@ | @::";
      base_branches = "bases:: & branches() & mine()";
      base_heads = "heads(bases::)";
      base_roots = "roots(bases:: ~ bases)";
    };

    core.fsmonitor = "watchman";

    colors = {
      "author name" = "yellow";
    };

    aliases = {
      l = ["log"];
      ll = ["log" "-r" "all()" "-l" "10"];
      s = ["status"];
      n = ["new" "-r" "base"];
      f = ["git" "fetch"];

      # Cleanup: has a long name because it is desctructive. Abandon
      # all empty descendents of 'bases'
      cleanup = ["abandon" "bases:: ~ bases & empty()"];

      rb = ["rebase" "-s" "base" "-d" "trunk()"];

      # Log Mine: Non-graph view of the head of the 10 most recent changesets
      # that are mine
      lm = ["log" "-r" "heads(mine())" "--no-graph" "-l" "10"];
    };

    ui = {
      default-command = "l";
      pager = "${delta}/bin/delta";
      diff-editor = "${meld}/bin/meld";
      diff = {
        format = "git";
      };
    };
  };
}
