{ pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    # Xwayland allows execute apps that do not support Wayland natively
    xwayland.enable = true;
    withUWSM = true;
  };

  hardware.graphics.enable = true;
  programs.regreet.enable = true;
  security.polkit.enable = true;

  environment.sessionVariables = {
    LIBGL_ALWAYS_SOFTWARE = "1";
  };

  environment.systemPackages = with pkgs; [
    # Core & UI
    qt6.qtwayland
    qt5.qtwayland
    qt6Packages.qt6ct
    xdg-user-dirs # This is just to create the User Dirs
    capitaine-cursors

    # System lock
    hyprlock
    hypridle
    hyprpolkitagent

    # Graphic interface
    waybar
    awww
    swaynotificationcenter
    rofi

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

  services = {
    dbus.enable = true;

    # Battery
    tlp.enable = true;
    # thermald.enable = true; # not available in aarch64

    # If screen is closed, we define suspension
    logind.settings.Login.HandleLidSwitch = "suspend";

    # gvfs is for recycler
    gvfs.enable = true;
    udisks2.enable = true;
  };
}
