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
  # programs.regreet.enable = true;
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
    xdg-desktop-portal-gtk # This is just to create the User Dirs
    capitaine-cursors

    # System lock
    hyprlock
    hypridle
    hyprpolkitagent

    # Graphic interface
    waybar
    awww
    libnotify
    swaynotificationcenter
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

    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "alexmatias";
          command = "${lib.getExe pkgs.tuigreet} --time --cmd start-hyprland"; # you may pass `--config` here
        };
      };
    };

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
