_:

{
  imports = [
    ../modules/core
    ../modules/packages
    ../modules/programs/herdr.nix
    ../modules/programs/shell.nix
    ../modules/programs/desktop-apps.nix
    ../modules/services/ssh.nix
    ../modules/development
    ../modules/services/tailscale.nix
    ../modules/services/backups.nix
    ../modules/services/flatpak.nix
    ../modules/services/podman.nix
    ../modules/desktop
  ];
}
