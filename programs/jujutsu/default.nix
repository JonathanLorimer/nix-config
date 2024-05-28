{ delta, meld }:
let 
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

    core.fsmonitor = "watchman";

    colors = {
      "author name" = "yellow";
    };

    aliases = {
      l = ["log" "-l" "10"];
      lm = ["log" "-r" "(trunk()..@):: | (trunk()..@)-"];
      s = ["status"];
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
