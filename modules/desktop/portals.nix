{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    # Backend portals ONLY: the base xdg-desktop-portal ships automatically
    # with enable, and wlr-layer-shell is a protocol implemented by the
    # compositor (Hyprland has it built in) — not something you install here.
    # NOTE: flake check does NOT force this list (lazy eval); a wrong
    # attribute name here only explodes on dry-build/switch. Always dry-build
    # after touching this file (see README troubleshooting).
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config.common.default = [
      "hyprland"
      "gtk"
    ];
  };
}
