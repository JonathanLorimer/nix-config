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

    git = {
      sign-on-push = true;
      push-new-bookmarks = false;
    };

    signing = {
      backend = "gpg";
      key = email;
    };

    templates = {
      annotate_commit_summary = let
        commit = "change_id.shortest(8)";
        username = "pad_end(16, truncate_end(16, author.name()))";
        commitDateAgo = "pad_end(13, truncate_end(13, committer.timestamp().local().ago()))";
      in "separate(\" \", ${commit}, ${username}, ${commitDateAgo})";
    };

    template-aliases = {
      "format_timestamp(timestamp)" = "timestamp.ago()";
      "format_short_signature(signature)" = "signature.name()";
    };

    revsets = {
      log = "@ | bases | working_lineage | base_branches | base_heads | base_roots";
    };

    revset-aliases = {
      bases = "present(bookmarks(base)) | trunk()";
      working_lineage = "bases::@ | @::";
      base_branches = "bases:: & bookmarks() & mine()";
      base_heads = "heads(bases::) & mine()";
      base_roots = "roots(bases:: ~ bases) & mine()";
      "base_to_branch(target)" = "bases::bookmarks(target) ~ bases";
    };

    core.fsmonitor = "watchman";

    colors = {
      "author name" = "yellow";
    };

    aliases = {
      l = ["log"];
      ll = ["log" "-r" "all()" "-n" "10"];
      lc = ["log" "-r" "::@" "-n" "10"];
      s = ["status"];
      n = ["new" "-r" "base"];
      f = ["git" "fetch"];
      back = ["edit" "-r" "@-"];

      # Cleanup: has a long name because it is desctructive. Abandon
      # all empty descendents of 'bases'
      cleanup = ["abandon" "bases:: ~ bases & empty()"];

      rb = ["rebase" "-s" "base" "-d" "trunk()"];

      # Log Mine: Non-graph view of the head of the 10 most recent changesets
      # that are mine
      lm = ["log" "-r" "heads(mine())" "--no-graph" "-n" "10"];

      nil = ["describe" "-m" "\"∅\""];
    };

    ui = {
      default-command = "l";
      pager = "${delta}/bin/delta";
      diff-editor = "${meld}/bin/meld";
      diff-formatter = ":git";
    };
  };
}
