{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/server.nix
  ];

  networking.hostName = "rpi-server";
}
