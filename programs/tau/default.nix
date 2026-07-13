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
    #### Source Control
    Prefer jj over git if a repo is colocated.
    Try and validate / justify assumptions against external resources (i.e. articles and documentation on the web).

    #### Implementation Process
    When implementing code solutions, try and come up with staged implementations, and remember to pause and check in after each stage.

    #### Comments
    Prefer terse comments. Avoid re-iterating information that is obvious from inspecting the implementation. Try and highlight
    implicit invariants, hidden coupling, product or historical reasons for an implementation.

    Use ASD-STE100 as a guide.
  '';
}
