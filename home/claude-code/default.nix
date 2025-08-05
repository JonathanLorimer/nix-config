{pkgs, ...}: {
  home.packages = with pkgs; [
    nushell
    libnotify
  ];

  # Create and manage ~/.claude directory
  home.file.".claude/settings.json".source = ./settings.json;
  home.file.".claude/CLAUDE.md".source = ./CLAUDE.md;
  home.file.".claude/conventional-commits.md".source = ./conventional-commits.md;

  # Hooks
  home.file.".claude/hooks/notify.nu" = {
    source = ./hooks/notify.nu;
    executable = true;
  };

  # Copy command files
  home.file.".claude/commands/task.md".source = ./commands/task.md;
  home.file.".claude/commands/commit-message.md".source = ./commands/commit-message.md;

  # Create necessary directories
  home.file.".claude/.keep".text = "";
  home.file.".claude/projects/.keep".text = "";
  home.file.".claude/todos/.keep".text = "";
  home.file.".claude/statsig/.keep".text = "";
  home.file.".claude/commands/.keep".text = "";
}
