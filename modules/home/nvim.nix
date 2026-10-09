# LazyVim starter, vendored verbatim from chezmoi dot_config/nvim
# (minus an accidental empty git skeleton under lua/config/, dropped).
#
# Nested inside home-manager.users like the rest of modules/home/*:
# this file is a NixOS module, NOT a Home Manager module.
#
# Out-of-store symlink (NOT read-only store link) on purpose, same as
# hypr/matugen/btop: lazy.nvim WRITES lazy-lock.json on plugin
# install/update, and LazyVim writes lazyvim.json on extras changes.
# A read-only store symlink crashes with "Read-only file system".
# Bonus: lockfile updates land in this repo file, so version pins stay
# committed — `git add lazy-lock.json` after intentional plugin changes.
{ config, ... }:

let
  home = config.users.users.alexmatias.home;
in
{
  home-manager.users.alexmatias = { config, ... }: {
    xdg.configFile."nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${home}/.config/nix-config/modules/home/nvim";
  };
}
