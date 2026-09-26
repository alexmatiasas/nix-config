# hosts/vm-gui/default.nix
# VM test for workstation profile (GUI + Hyprland + Noctalia).
# Keep hosts/laptop clean for future real hardware.

{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ../../profiles/workstation.nix
    ../../profiles/ml-workstation.nix
    ../../modules/core/boot.nix
    ../../modules/core/swap.nix

    ./hardware-configuration.nix
  ];

  networking.hostName = "vm-gui";

  # Software rendering: the VM has no GPU.
  environment.sessionVariables = {
    LIBGL_ALWAYS_SOFTWARE = "1";
  };
}
