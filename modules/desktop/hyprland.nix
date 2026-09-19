{ pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    # Xwayland allows execute apps that do not support Wayland natively
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    waybar
    wofi
    dunst
    hyprpaper
    kitty
    swaybg
    grim
    slurp
  ];

  services.dbus.enable = true;
}
