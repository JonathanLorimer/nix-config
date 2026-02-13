{
  # Generate hostId on erymanthian with:
  #   head -c4 /dev/urandom | od -A none -t x4 | tr -d ' '
  networking.hostId = "f4052fab";
  networking.hostName = "erymanthian";
}
