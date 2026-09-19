_:

{
  imports = [
    ../modules/core
    ../modules/packages
    ../modules/programs/herdr.nix
    ../modules/programs/shell.nix
    ../modules/services/ssh.nix
    ../modules/services/tailscale.nix
    ../modules/services/backups.nix
    ../modules/services/podman.nix
    ../modules/desktop
  ];
}
