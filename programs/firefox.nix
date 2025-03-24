{pkgs}: {
  enable = true;
  profiles = {
    default = {
      id = 0;
      name = "Jonathan";
      bookmarks = {
        force = true;
        settings = [
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
      };
    };
  };
}
