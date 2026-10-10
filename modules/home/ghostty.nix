# Ghostty config, vendored verbatim from chezmoi dot_config/ghostty/.
# The tree is already cross-platform by design: `?platform-macos.ghostty`
# is an optional include (ignored on Linux). macOS-only keys elsewhere
# (macos-window-buttons, cmd+ keybinds) are inert on Linux.
# Binary comes from nixpkgs (see hyprland.nix); kitty stays installed
# as fallback terminal.
{
  home-manager.users.alexmatias = {
    xdg.configFile."ghostty" = {
      source = ./ghostty;
      recursive = true;
    };
  };
}
