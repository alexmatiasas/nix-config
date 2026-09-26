_:

{
  imports = [
    ../modules/core/default.nix
    ../modules/programs/shell.nix
    ../modules/services/ssh.nix
    ../modules/services/tailscale.nix
    ../modules/services/podman.nix
    ../modules/services/backups.nix
  ];

  # Weekly automatic upgrade with reboot allowed.
  # NOTE: if the repo is private, the system (root) needs read access:
  #   option A: make it public (your stated goal),
  #   option B: deploy a read-only deploy key to /root/.ssh,
  #   option C: point flake at the local path and `git pull` manually first.
  system.autoUpgrade = {
    enable = true;
    flake = "github:alexmatiasas/nix-config#rpi-server";
    dates = "weekly";
    randomizedDelaySec = "30min";
    allowReboot = true;
  };
}
