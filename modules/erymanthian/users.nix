{pkgs, ...}: {
  users = {
    users.root = {
      hashedPassword = "$6$CCPiA5lnUSwEshCI$yQeiierbX1geYhRxthtu34bcOkjvErUxriGTUesSul2outHlOBKOevdPtKtbDk00fxPkePxxQum0zltajgvJC1";
    };
    users.jonathanl = {
      isNormalUser = true;
      createHome = true;
      hashedPassword = "$6$CCPiA5lnUSwEshCI$yQeiierbX1geYhRxthtu34bcOkjvErUxriGTUesSul2outHlOBKOevdPtKtbDk00fxPkePxxQum0zltajgvJC1";
      extraGroups = ["wheel" "audio" "video" "sway" "networkmanager" "plugdev"];
      home = "/home/jonathanl";
      shell = pkgs.zsh;
    };
  };
  programs.zsh.enable = true;
}
