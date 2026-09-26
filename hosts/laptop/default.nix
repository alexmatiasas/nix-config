# hosts/laptop/default.nix

_:

{
  imports = [
    ../../profiles/workstation.nix
    ../../profiles/ml-workstation.nix
    ../../modules/core/boot.nix
    ../../modules/core/swap.nix

    ./hardware-configuration.nix
  ];

  networking.hostName = "ruhtra";

  # Software rendering: the VM has no GPU. On real hardware with a GPU,
  # remove this variable to use hardware acceleration.
  environment.sessionVariables = {
    LIBGL_ALWAYS_SOFTWARE = "1";
  };
}
