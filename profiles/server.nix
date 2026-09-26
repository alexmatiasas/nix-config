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

  # Actualización automática semanal con reboot permitido.
  # NOTA: si el repo es privado, el sistema (root) necesita acceso:
  #   opción A: hazlo público (tu meta declarada),
  #   opción B: despliega una deploy-key de solo-lectura en /root/.ssh,
  #   opción C: cambia flake a la ruta local y haz `git pull` manual antes.
  system.autoUpgrade = {
    enable = true;
    flake = "github:alexmatiasas/nix-config#rpi-server";
    dates = "weekly";
    randomizedDelaySec = "30min";
    allowReboot = true;
  };
}
