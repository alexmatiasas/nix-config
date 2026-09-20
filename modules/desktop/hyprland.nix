{ pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    # Xwayland allows execute apps that do not support Wayland natively
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Core & UI
    waybar
    rofi
    mako
    awww
    hyprlock
    hypridle

    # Screenshots and utils
    grim
    slurp
    swappy
    cliphist
    wl-clipboard

    # Terminal
    kitty

    # Audio
    pamixer
    pavucontrol

    # Network
    networkmanagerapplet

    # Bluetooth
    blueman

    # Weather
    wttrbar

  ];

  services.dbus.enable = true;
}
