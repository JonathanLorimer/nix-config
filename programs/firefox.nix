{pkgs}: {
  enable = true;
  profiles = {
    default = {
      id = 0;
      name = "Jonathan";
      bookmarks = [
        {
          name = "Toolbar";
          toolbar = true;
          bookmarks = [
            {
              name = "RSS Reader";
              url = "localhost:8031";
            }
          ];
        }
      ];
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        darkreader
        vimium
        zotero-connector
        onepassword-password-manager
        react-devtools
      ];
    };
  };
}
