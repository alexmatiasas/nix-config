{ pkgs, ... }: {
  users.users.alexmatias = {
    isNormalUser = true;
    description = "Alex Matías";
    extraGroups = [
      "wheel"
      "video"
      "input"
      "networkmanager"
    ];
    shell = pkgs.zsh;

    # Declarative login password (required for graphical SDDM login;
    # SSH keys don't apply there). Rotate by editing this repo + rebuild.
    hashedPassword = "$6$aHHHxu2zIXYL7PJr$FmjRavbaXDmGhwjPpV3vthvTobZ3wDOuBZ6DQ3vRVANRrm2V7Y8F/JQHCtv71PurGCuVRjaT3IvnEUy7C4cl9.";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEvriL6yohuz3kNEPP2QQ/PungiDGgqIyTX4iUfLzl92 alejandromatiasas@gmail.com"
    ];
  };
}
