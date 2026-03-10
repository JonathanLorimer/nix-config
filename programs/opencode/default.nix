{
  enable = true;
  settings = {
    autoupdate = true;
    mcp = {
      linear = {
        type = "local";
        command = ["npx" "-y" "mcp-remote" "https://mcp.linear.app/mcp"];
      };
    };
  };
}
