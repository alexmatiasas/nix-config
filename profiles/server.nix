_:

{
  imports = [
    ../modules/core/default.nix
    ../modules/services/ssh.nix
    ../modules/services/tailscale.nix
    ../modules/services/podman.nix
    ../modules/services/backups.nix
  ];
}
