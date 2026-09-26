_:

{
  imports = [
    ../modules/core/default.nix
    ../modules/packages
    ../modules/programs/shell.nix
    ../modules/programs/herdr.nix
    ../modules/services/ssh.nix
    ../modules/services/tailscale.nix
    ../modules/services/podman.nix
    ../modules/services/flatpak.nix
    ../modules/services/backups.nix
    ../modules/development/default.nix
    ../modules/desktop/default.nix
  ];
}
