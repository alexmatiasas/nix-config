{ pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    # Xwayland allows execute apps that do not support Wayland natively
    xwayland.enable = true;
    withUWSM = true;
  };

  environment.systemPackages = with pkgs; [
    # Core & UI
    xdg-desktop-portal-hyprland
    qt6.qtwayland
    qt5.qtwayland
    qt6Packages.qt6ct

    # System lock
    hyprlock
    hypridle
    hyprpolkitagent
    greetd
    greetd.regreet

    # Graphic interface
    waybar
    awww
    swaynotificationcenter
    rofi
    mako

    # Screenshots and utils
    grim
    slurp
    swappy
    cliphist
    wl-clipboard
    brightnessctl
    thunar

    # Terminal
    kitty

    # Audio
    pamixer
    pwvucontrol
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
