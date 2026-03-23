{
  boot.kernelParams = ["nouveau.runpm=0"];

  # Nouveau's GSP firmware on the RTX 5000 Ada cannot survive suspend/resume,
  # so we disable lid-close suspend to prevent the GPU from entering a broken
  # state. Swayidle handles screen locking and DPMS instead.
  services.logind.settings.Login = {
    HandleLidSwitch = "lock";
    HandleLidSwitchDocked = "lock";
  };
}
