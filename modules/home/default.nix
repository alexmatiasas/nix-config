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

let
  # Home dir from the NixOS side (outer `config`); the inner per-user
  # module below has its own `config` where config.lib.file.* (HM lib) lives.
  home = config.users.users.alexmatias.home;
in

{
  home-manager.users.alexmatias = { config, ... }: {
    # Must match the home-manager input (release-26.05). Never change after
    # first switch: it gates HM's own migration behavior, not your dotfiles.
    home.stateVersion = "26.05";

    xdg.configFile."hypr".source =
      config.lib.file.mkOutOfStoreSymlink "${home}/.config/nix-config/modules/home/hypr";

    # Matugen inputs (config.toml + templates). Out-of-store so templates
    # can be iterated without rebuild. DMS runs matugen on wallpaper/theme
    # changes and executes these alongside its built-in templates.
    # NOTE: DMS docs require template entries under [config] with ABSOLUTE
    # paths — see modules/home/matugen/config.toml. Do not use ~/ here.
    xdg.configFile."matugen".source =
      config.lib.file.mkOutOfStoreSymlink "${home}/.config/nix-config/modules/home/matugen";

    # btop config (color_theme = "matugen"). Whole dir out-of-store like
    # hypr: matugen must write themes/matugen.theme next to btop.conf.
    # NOTE: btop rewrites btop.conf on exit (save_config_on_exit) and
    # matugen rewrites themes/ — both dirty git status; gitignore covers
    # the generated theme, btop.conf noise is the cost of live theming.
    xdg.configFile."btop".source =
      config.lib.file.mkOutOfStoreSymlink "${home}/.config/nix-config/modules/home/btop";
  };
}
