{pkgs}: {
  enable = true;
  settings = {
    defaultProvider = "anthropic";
    theme = "dark";
  };
  toolDeps = with pkgs; [fd ripgrep git jq jujutsu nix coreutils];
  extensions = {
    pi-subagents = import ./pi-subagents.nix {inherit pkgs;};
    pi-mcp-adapter = import ./pi-mcp-adapter.nix {inherit pkgs;};
  };
  appendSystemPrompt = ''
    Prefer jj over git if a repo is colocated.
    Try and validate / justify assumptions against external resources (i.e. articles and documentation on the web).
    When implementing code solutions, try and come up with staged solutions, and remember to pause and check in after each stage.
  '';
}
