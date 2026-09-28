# Fallback desktop for maximum app compatibility (XWayland maturity,
# Qt+GTK integration, SDDM-native). DISABLED by default: Hyprland+DMS is the
# daily driver. To use it, uncomment the import in desktop/default.nix and
# pick the "Plasma" session at login. (~2GB closure: only pay it if needed.)
{ pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;

  # KDE portal first inside Plasma sessions so file dialogs, screenshare
  # and app choosers use the native backend instead of GTK's.
  xdg.portal = {
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    config.kde.default = [
      "kde"
      "gtk"
    ];
  };
}
