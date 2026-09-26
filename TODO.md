# TODOs del repo (backlog por perfil)

> Convención: cada TODO tiene su trigger (cuándo hacerlo) para no trabajar
> antes de tiempo. Nada de esta lista debe romper `nix flake check`.

## Servidor (`rpi-server` / `profiles/server.nix`)

- [ ] **Disco USB**: conseguir adaptador USB 3.0↔SATA (con fuente propia si el
      disco es 3.5"). Formatear ext4, montar declarativo por UUID en
      `hosts/rpi-server` bajo `/data`. _Trigger: tener el adaptador._
- [ ] **Restic real**: `restic init -r /data/backups`, guardar la contraseña
      (ver sops), reactivar servicio+timer en `modules/services/backups.nix`
      (hoy comentados a propósito), y hacer un **restore de prueba**.
      Sin restore probado no hay backup. _Trigger: disco montado._
- [ ] **sops**: introducirlo cuando exista el primer secreto real
      (password de restic o de Postgres). _Trigger: primer password._
- [ ] **Jellyfin** (primer servicio, aprender Quadlet): un contenedor,
      volúmenes en `/data`, acceso vía Tailscale. _Trigger: disco montado._
- [ ] **Filebrowser/drive** (segundo servicio). _Trigger: Jellyfin andando._
- [ ] **Postgres** (tercer servicio, ya pide sops). _Trigger: proyecto que
      necesite DB + sops funcionando._
- [ ] **Monitoring**: uptime-kuma o chequeo mínimo (systemd + timer que avise).
      _Trigger: 2+ servicios en producción._
- [ ] Revisar `system.autoUpgrade` tras el primer mes (logs del timer).
- [ ] En **Pi física** (no VM): cambiar `core/boot.nix` por
      `boot.loader.generic-extlinux-compatible.enable = true`.

## Workstation (`laptop` / `vm-gui` / `profiles/workstation.nix`)

- [ ] **Triage `modules/programs/desktop-apps.nix`** (huérfano, nadie lo
      importa): clasificar por app → nixpkgs aarch64 OK / solo x86_64 /
      mover a Flatpak. Candidatos a Flatpak: Zettlr, Spotify, Discord,
      Zoom, Obsidian. _Trigger: VM `vm-gui` levantada._
- [ ] **Pulido Noctalia**: partir de su default e ir sobreescribiendo
      (barra, temas, dock). _Trigger: `vm-gui` bootea a Hyprland._
- [ ] **Identidad chezmoi**: zsh/zinit/starship, kitty, waybar V7.1a limpia,
      mako, fondo. _Trigger: base workstation estable en `vm-gui`._
- [ ] **Inventario Flatpak**: verificar en `vm-gui` los 12 IDs de
      `modules/services/flatpak.nix` (3 ya excluidos por no existir).
- [ ] **CUDA**: `modules/data-science/cuda.nix` y `hardware/nvidia.nix`
      vacíos a propósito — en ARM no hay NVIDIA; solo importan para la
      futura caja x86_64 con GPU. _Trigger: tener ese hardware._
- [ ] `modules/desktop/printing.nix` existe pero `desktop/default.nix`
      no lo importa. Decidir si la workstation imprime.
- [ ] Limpiar stubs vacíos: `programs/cli.nix`, `programs/development.nix`,
      `development/containers.nix`, `services/monitoring.nix`,
      `data-science/python.nix`.
- [x] `qylock` integrado (`modules/desktop/qylock.nix`, tema `dog-samurai`).
      Cambiar de tema = una palabra en ese archivo.

## Global

- [ ] Soporte x86_64 real (hoy todo hardcodea `aarch64-linux` en el flake).
- [ ] Limpieza para repo público (secretos, rutas absolutas, README al día).
- [ ] `profiles/ml-workstation.nix` vacío: definirlo cuando exista el
      servidor de cómputo (recomendado: perfil servidor, no workstation).
