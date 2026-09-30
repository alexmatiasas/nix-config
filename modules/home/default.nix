# modules/home/default.nix
#
# Home Manager user files. This is what actually installs modules/home/*
# into ~/.config (without a home-manager.users block, those dirs are
# dead weight: the flake builds fine but deploys nothing).
#
# hypr/ is linked with mkOutOfStoreSymlink (NOT a store symlink) on
# purpose: matugen (driven by DMS dynamic theming) must WRITE
# colors.conf/colors.lua next to the rest of the hypr config.
# A read-only store symlink would break generation. Tradeoff: generated
# files dirty `git status` in this repo — gitignore them once colors
# pipeline is verified (see colors.lua thread).
{ config, ... }:

{
  home-manager.users.alexmatias = {
    xdg.configFile."hypr".source =
      config.lib.file.mkOutOfStoreSymlink "${config.users.users.alexmatias.home}/.config/nix-config/modules/home/hypr";
  };
}
