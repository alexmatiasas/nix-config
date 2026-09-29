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
    # Icon themes live HERE, never in environment.systemPackages: flatpak's
    # NixOS patch walks every system icons/fonts dir resolving each symlink
    # (~10 syscalls per icon) when FHS paths are absent, turning every
    # flatpak launch into minutes with thousands of loose-symlink icons.
    # User-profile paths are invisible to that walk but still found by
    # native apps via ~/.nix-profile/share.
    packages = with pkgs; [
      papirus-icon-theme
      catppuccin-papirus-folders
    ];

    # Declarative login password (graphical logins need it; SSH keys don't
    # apply there). Rotate by editing this repo + rebuild.
    hashedPassword = "$6$aHHHxu2zIXYL7PJr$FmjRavbaXDmGhwjPpV3vthvTobZ3wDOuBZ6DQ3vRVANRrm2V7Y8F/JQHCtv71PurGCuVRjaT3IvnEUy7C4cl9.";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEvriL6yohuz3kNEPP2QQ/PungiDGgqIyTX4iUfLzl92 alejandromatiasas@gmail.com"
    ];
  };
}
