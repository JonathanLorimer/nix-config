{pkgs}: {
  enable = true;
  settings = {
    plugin = [
      pkgs.opencode-claude-auth
    ];
    autoupdate = true;
    mcp = {
      linear = {
        type = "local";
        command = ["npx" "-y" "mcp-remote" "https://mcp.linear.app/mcp"];
      };
    };
  };
}
