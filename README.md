# nix-config

Personal, reproducible NixOS setup (flakes) for a workstation and a home server.
`aarch64-linux` today, `x86_64-linux` planned. Dotfiles (shell, editor,
desktop look) live in a separate **chezmoi** repo — this flake owns the
**system base** only: packages, services, users, hardware.

## Layout

```text
flake.nix            # inputs (nixpkgs, herdr, noctalia) + nixosConfigurations
hosts/               # one dir per MACHINE (hardware-specific: bootloader, swap,
                     #   filesystems, hostname). Pick one and switch to it.
  rpi-server/        # home server (today: VM w/ UEFI; physical Pi needs extlinux, see TODO)
  laptop/            # main dev machine (real hardware, future)
  vm-gui/            # throwaway VM to test the workstation profile
profiles/            # one file per ROLE (what the machine DOES)
  server.nix         # headless: core + ssh + tailscale + podman + backups + autoUpgrade
  workstation.nix    # daily driver: server-base + packages + dev stacks + desktop + noctalia
  ml-workstation.nix # reserved for the future GPU compute box
modules/             # the actual config, grouped by DOMAIN
  core/              # locale, networking, nix (GC/flakes), security, users
  core/boot.nix      # systemd-boot (imported per-host, NOT from core/default)
  core/swap.nix      # 4 GiB swapfile (laptop/VM only; server uses zram)
  hardware/          # nvidia / raspberry-pi (empty until the hardware exists)
  services/          # ssh, tailscale, podman, flatpak, backups (kopia), autoUpgrade
  desktop/           # hyprland (+sddm, waybar, mako, rofi, dock, thunar…), audio,
                     #   bluetooth, fonts, portals, firmware, gstreamer
  development/       # go, python (uv/ruff), node (fnm/pnpm), rust, toolchain, math
  data-science/      # cuda (empty: no NVIDIA on ARM; x86_64 GPU box only)
  packages/          # base + workstation + dev-tools package lists
  programs/          # shell (zsh/starship/git…), herdr, desktop-apps (UNUSED, see below)
scripts/             # rebuild.sh, install-host.sh, push-terminfo.sh
TODO.md              # backlog per profile with triggers (nothing here should break check)
```

Rules of thumb:

- **Hardware** (bootloader, swap, filesystems, hostname) goes in `hosts/`, never in `core/`.
- **Role** (server vs workstation) goes in `profiles/`, which only *import* domains.
- `modules/programs/desktop-apps.nix` is currently **orphaned on purpose**: several
  apps don't build on `aarch64` (e.g. Zettlr). See TODO.md for the triage plan
  (nixpkgs vs Flatpak per app).
- Dotfiles rule: if a change lives in chezmoi (aliases, waybar style, hyprland
  keybinds), do **NOT** `nixos-rebuild` for it — just `chezmoi apply`.

## Daily workflow

Recommended: [`nh`](https://github.com/viperML/nh) (installed on every host via
`modules/programs/shell.nix`, flake pinned through `NH_FLAKE` — no setup needed):

```sh
nh os switch          # hostname -> right nixosConfiguration, activate now
nh os boot            # activate on next reboot (safer for remote machines)
nh clean all          # garbage-collect old generations (respects nix.gc too)
```

Caveat: `nh` picks the config by **machine hostname**. `rpi-server` and `vm-gui`
match their config names; the laptop's hostname is `ruhtra` while its config is
`laptop`, so there use `nh os switch -H laptop` (or rename one to match).

No `/etc/nixos` symlink: with flakes it buys nothing (you still need `--flake`),
confuses `nixos-generate-config`, and tangles multi-host setups. `nh` (+ plain
`nixos-rebuild` fallback) is the current community convention.

Without `nh`, or from this repo dir:

```sh
./scripts/rebuild.sh <host> --dry     # nix flake check + dry-build (safe, default)
./scripts/rebuild.sh <host> --switch  # check + dry-build + activate now
./scripts/rebuild.sh <host> --boot    # check + dry-build + activate next reboot
```

Always in this order: `flake check` (syntax) → `dry-build` (full evaluation;
`check` is lazy and misses things like bad package attributes) → `switch`.
Snapshot the VM before risky switches.

## Fresh install (from the NixOS ISO)

Partitioning first (GPT + ESP + root), then delegate the rest to the script:

```sh
# 0. as root on the ISO: partition, format, mount under /mnt (details below)
# 1. generate the hardware config for THIS machine:
nixos-generate-config --root /mnt
# 2. install this flake for the wanted host:
nix-shell -p git --run "./scripts/install-host.sh <host>"
#    (clone this repo first, or curl the script; it copies the generated
#    hardware-configuration.nix into hosts/<host>/ and runs nixos-install)
```

### Partition the disk (GPT + ESP + root)

```sh
lsblk   # find the disk, e.g. /dev/vda
parted /dev/vda -- mklabel gpt
parted /dev/vda -- mkpart ESP fat32 1MB 512MB
parted /dev/vda -- set 1 esp on
parted /dev/vda -- mkpart primary ext4 512MB 100%
mkfs.fat -F32 -n boot /dev/vda1
mkfs.ext4 -L nixos /dev/vda2
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
```

Notes: `--` passes the rest as command (UNIX convention); `mklabel gpt` wipes the
table; the ESP flag tells UEFI firmware where the bootloader lives; labels
(`boot`, `nixos`) let NixOS reference partitions by name instead of raw paths;
`/mnt` becomes the new system's `/` — anything outside it is lost on reboot.

## Operations

- **SSH**: key-only, `alexmatias` user. From the Mac: `ssh alexmatias@<host>`.
- **Tailscale**: `sudo tailscale up` once per machine; the server is reachable
  only over the tailnet (no ports exposed to the internet).
- **Server upgrades**: `system.autoUpgrade` weekly + auto-reboot (server profile).
  Needs repo access for root — see the NOTE in `profiles/server.nix`.
- **Backups**: `kopia` binary installed; repo + schedule are TODOs gated on the
  USB disk (see TODO.md). No restore tested = no backup.
- **Flatpaks** (workstation only): `services.flatpak.enable` + an install service
  generated from a Nix list (`modules/services/flatpak.nix`). IDs that don't
  exist on Flathub are excluded with a comment saying why.
- **Ghostty over SSH**: macOS Ghostty sets `TERM=xterm-ghostty`, unknown to the
  remote terminfo DB (broken colors/keys). Run once per host:

```sh
./scripts/push-terminfo.sh alexmatias@<host-ip>
```

## Troubleshooting (errors we actually hit)

| Symptom | Cause | Fix |
|---|---|---|
| `Unsupported system: aarch64-linux` | package with no ARM build (was `mongodb-compass`) | comment out / move to Flatpak |
| `permittedInsecurePackages` blocks build (electron, ventoy) | known CVE, version-pinned | add exact version to `nixpkgs.config.permittedInsecurePackages` (re-check on every `flake update`) |
| `shell is set to zsh, but programs.zsh.enable is not true` | profile imports users without `programs/shell.nix` | import `shell.nix` in that profile |
| `undefined variable 'network-manager-applet'` | wrong attr name (dashes); real one is `networkmanagerapplet` | use the nixpkgs attribute, not the binary name |
| `unexpected '//'` | `//` comments are illegal in Nix (use `#`) | fix the comment |
| `services.X` nested inside `services = { }` | double nesting | hoist to top-level `services.X` |
| `systemd.logind does not exist` | wrong path | `services.logind.settings…` |
| `system.extraDependencies` unknown | not a NixOS option | `environment.systemPackages` |
| `Path … is not tracked by Git` | flakes only see `git add`-ed files | `git add -N <path>` (no commit needed) |
| `Neither nixpkgs.hostPlatform nor nixpkgs.system has been set` | host without platform (empty hw stub) | pass `system` in flake or generate hw config |
| `The option services.zramSwap does not exist` | wrong path | top-level `zramSwap` |
| `flatpak-install-apps.service` failed, exit 4 | bad Flathub IDs (Slack/Dropbox/Teams don't exist there) | remove them; lines end in `\|\| true` so one bad app can't fail the switch |
