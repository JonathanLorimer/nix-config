{
  pkgs,
  config,
}: {
  enable = true;
  settings = {
    defaultProvider = "anthropic";
    theme = "zenwritten-desat";
    subagents = {
      disableBuiltins = true;
    };
  };
  toolDeps = with pkgs; [fd ripgrep git jq jujutsu nix coreutils];
  extensions = {
    subagent = import ./pi-subagents.nix {inherit pkgs;};
    pi-mcp-adapter = import ./pi-mcp-adapter.nix {inherit pkgs;};
  };
  skills = {
    rdpi = ./skills/rdpi;
  };
  xdgOpenShimPath = "${config.home.homeDirectory}/.pi/agent/extensions/pi-mcp-adapter/node_modules/open/xdg-open";
  appendSystemPrompt = ''
    Prefer jj over git if a repo is colocated.
    Try and validate / justify assumptions against external resources (i.e. articles and documentation on the web).
    When implementing code solutions, try and come up with staged solutions, and remember to pause and check in after each stage.
  '';
}
