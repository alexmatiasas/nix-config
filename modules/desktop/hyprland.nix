{ pkgs, lib, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    # Xwayland allows execute apps that do not support Wayland natively
    xwayland.enable = true;
    withUWSM = true;
  };

  hardware.graphics.enable = true;
  security.polkit.enable = true;

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

    # Screenshots and utils
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

  services = {
    dbus.enable = true;

    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "alexmatias";
          command = "${lib.getExe pkgs.tuigreet} --time --cmd start-hyprland";
        };
      };
    };

    # Battery & Power
    tlp.enable = true;
    logind.settings.Login.HandleLidSwitch = "suspend";

    # File system utilities
    gvfs.enable = true;
    udisks2.enable = true;
  };
}
