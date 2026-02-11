{
  # Generate hostId on erymanthian with:
  #   head -c4 /dev/urandom | od -A none -t x4 | tr -d ' '
  networking.hostId = "XXXXXXXX";
  networking.hostName = "erymanthian";
}
