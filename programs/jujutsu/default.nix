{ delta }:
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
  
    ui = {
      default-command = "status";
      pager = "${delta}/bin/delta";
      diff.format = "git";
    };
  };
}
