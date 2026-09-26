# hosts/laptop/default.nix

_:

{
  imports = [
    ../../profiles/workstation.nix
    ../../profiles/ml-workstation.nix

    ./hardware-configuration.nix
  ];

  networking.hostName = "ruhtra";
}
