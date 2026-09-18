# hosts/laptop/default.nix

_:

{
  imports = [
    ../../profiles/workstation.nix
    ../../profiles/desktop.nix

    ./hardware-configuration.nix
  ];

  networking.hostName = "ruhtra";
}
