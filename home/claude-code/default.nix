{pkgs, ...}: {
  home.packages = with pkgs; [
    nushell
    libnotify
  ];

  # Create and manage ~/.claude directory
  home.file.".claude/settings.json".source = ./settings.json;
  home.file.".claude/CLAUDE.md".source = ./CLAUDE.md;

  # Hooks
  home.file.".claude/hooks/checkpoint.nu" = {
    source = ./hooks/checkpoint.nu;
    executable = true;
  };
  home.file.".claude/hooks/notify.nu" = {
    source = ./hooks/notify.nu;
    executable = true;
  };

  # Copy command files
  home.file.".claude/commands/task.md".source = ./commands/task.md;

  # Create necessary directories
  home.file.".claude/.keep".text = "";
  home.file.".claude/projects/.keep".text = "";
  home.file.".claude/todos/.keep".text = "";
  home.file.".claude/statsig/.keep".text = "";
  home.file.".claude/commands/.keep".text = "";
}
