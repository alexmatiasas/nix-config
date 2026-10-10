# Ghostty config, vendored verbatim from chezmoi dot_config/ghostty/.
# The tree is already cross-platform by design: `?platform-macos.ghostty`
# is an optional include (ignored on Linux). macOS-only keys elsewhere
# (macos-window-buttons, cmd+ keybinds) are inert on Linux.
# Binary comes from nixpkgs (see hyprland.nix); kitty stays installed
# as fallback terminal.
#
# Out-of-store symlink: ghostty hot-reloads its config on save, so editing
# modules/home/ghostty/* applies instantly with no switch. Review with
# `git diff`, commit keepers.
{ config, ... }:

let
  home = config.users.users.alexmatias.home;
in
{
  home-manager.users.alexmatias = { config, ... }: {
    xdg.configFile."ghostty".source =
      config.lib.file.mkOutOfStoreSymlink "${home}/.config/nix-config/modules/home/ghostty";
  };
}
