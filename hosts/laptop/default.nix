# hosts/laptop/default.nix

{ ... }:

{
  imports = [
    ../../profiles/workstation.nix
    ../../profiles/desktop.nix

    ./hardware-configuration.nix
  ];

  networking.hostName = "ruhtra";
}
