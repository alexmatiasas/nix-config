{ pkgs, ... }:

{
  # Niri: scrollable-tiling compositor, DMS's home turf (default on DankLinux).
  # Trial alongside Hyprland: pick the session at login, compare for a week.
  # If it sticks, it becomes primary and Hyprland drops to fallback.
  programs.niri.enable = true;

  # On-demand X11 backend: niri spawns it automatically when an X11-only
  # window appears. No X11 apps known today; cheap insurance either way.
  environment.systemPackages = with pkgs; [ xwayland-satellite ];
}
