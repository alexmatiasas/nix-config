{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
      pkgs.wlr-layer-shell
    ];
    config.common.default = [
      "hyprland"
      "gtk"
    ];
  };
}
