{ pkgs, lib, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  hardware.graphics.enable = true;
  security.polkit.enable = true;

  environment.sessionVariables = {
    LIBGL_ALWAYS_SOFTWARE = "1";
  };

  environment.systemPackages = with pkgs; [
    # Core & UI
    qt6.qtwayland
    qt5.qtwayland
    qt6Packages.qt6ct
    xdg-user-dirs
    xdg-desktop-portal-gtk
    capitaine-cursors

    # System lock & Idle
    hyprlock
    hypridle
    hyprpolkitagent

    # Graphic interface
    waybar
    mako
    wttrbar
    catppuccin-gtk
    papirus-icon-theme
    uwsm
    networkmanagerapplet
    awww
    libnotify
    rofi
    rofimoji
    nwg-dock-hyprland
    nwg-drawer
    nwg-look
    kdePackages.qtstyleplugin-kvantum

    # Multimedia & Utils
    grim
    slurp
    swappy
    cliphist
    wl-clipboard
    imv
    libjpeg_turbo
    libwebp
    librsvg
    brightnessctl
    thunar
    thunar-archive-plugin
    tumbler
    ffmpegthumbnailer
    imagemagick
    chafa
    papirus-folders
    catppuccin-papirus-folders
    gum
    hyprcursor
    gnome-software
    hyprdim
    hyprdynamicmonitors
    hyprkeys
    hyprls

    # Terminal
    kitty
  ];

  # Display Manager: SDDM for a polished, themed login experience
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.dbus.enable = true;

  # Battery & Power
  # tlp intentionally OFF: Noctalia recommendedServices provides
  # power-profiles-daemon instead (see noctalia.nix); both conflict.
  services.tlp.enable = false;
  services.logind.settings.Login.HandleLidSwitch = "suspend";

  # File system utilities
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
