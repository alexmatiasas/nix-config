#!/usr/bin/env bash
# Fresh-install helper, run as root from the NixOS installer ISO
# after partitioning, formatting and mounting under /mnt.
# Usage: ./scripts/install-host.sh <host>
# What it does:
#   1. clones this repo to /tmp/nix-config
#   2. copies the generated hardware-configuration.nix into hosts/<host>/
#   3. removes the default /mnt/etc/nixos/configuration.nix
#   4. runs nixos-install against the flake
set -euo pipefail

HOST="${1:?Usage: install-host.sh <host> (rpi-server | laptop | vm-gui)}"
REPO_URL="https://github.com/alexmatiasas/nix-config.git"
WORKDIR="/tmp/nix-config"

if [[ $EUID -ne 0 ]]; then
  echo "Run as root (sudo su) from the installer ISO." >&2
  exit 1
fi

if [[ ! -f /mnt/etc/nixos/hardware-configuration.nix ]]; then
  echo "Missing /mnt/etc/nixos/hardware-configuration.nix." >&2
  echo "Mount partitions under /mnt and run nixos-generate-config --root /mnt first." >&2
  exit 1
fi

echo "==> cloning ${REPO_URL} to ${WORKDIR}"
rm -rf "$WORKDIR"
git clone --depth 1 "$REPO_URL" "$WORKDIR"

echo "==> installing hardware-configuration.nix for ${HOST}"
cp /mnt/etc/nixos/hardware-configuration.nix "$WORKDIR/hosts/${HOST}/hardware-configuration.nix"

echo "==> removing default configuration.nix"
rm -f /mnt/etc/nixos/configuration.nix

echo "==> nixos-install --flake ${WORKDIR}#${HOST}"
nixos-install --flake "${WORKDIR}#${HOST}"

echo "Done. Copy ${WORKDIR}/hosts/${HOST}/hardware-configuration.nix back"
echo "into your checkout if it was newly generated, then reboot."
