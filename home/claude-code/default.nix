{pkgs, ...}: {
  home.packages = with pkgs; [
    nushell
    libnotify
  ];

  # Create and manage ~/.claude directory
  home.file.".claude/settings.json".source = ./settings.json;
  home.file.".claude/output-styles/minimal.md".source = ./output-styles/minimal.md;
  home.file.".claude/commands/ticket.md".source = ./commands/ticket.md;

  # Hooks
  home.file.".claude/hooks/notify.nu" = {
    source = ./hooks/notify.nu;
    executable = true;
  };

  # Create necessary directories
  home.file.".claude/.keep".text = "";
  home.file.".claude/projects/.keep".text = "";
  home.file.".claude/todos/.keep".text = "";
  home.file.".claude/statsig/.keep".text = "";
}
