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
  systemd.user.extraConfig = ''
    DefaultEnvironment="WAYLAND_DISPLAY=wayland-1" "XDG_CURRENT_DESKTOP=Hyprland" "XDG_SESSION_TYPE=wayland"
  '';

  environment.systemPackages = with pkgs; [
    # Core & UI
    qt6.qtwayland
    qt5.qtwayland
    qt6Packages.qt6ct
    xdg-user-dirs
    xdg-desktop-portal-gtk
    capitaine-cursors

    # System lock & Idle
    # DMS owns lock screen + idle management. Kept commented as fallback:
    # uncomment if DMS ever breaks and you need to lock the session.
    # hyprlock
    # hypridle
    hyprpolkitagent

    # Graphic interface
    # DMS owns the shell (bar, notifications, launcher, wallpaper, dock).
    # The pre-DMS stack below is commented out as fallback: uncomment if DMS
    # breaks and you need a working bar/notifications/launcher immediately.
    # waybar
    firefox
    # Native browser: starts far faster than the Flatpak (cold-start
    # cost + sandbox overhead measured in minutes on this VM).
    # Flatpak Firefox stays in inventory as backup.
    # mako
    # wttrbar # waybar weather backend; useless without waybar
    catppuccin-gtk
    papirus-icon-theme
    uwsm
    networkmanagerapplet
    # awww # wallpaper daemon; DMS manages wallpaper now
    libnotify
    # rofi # DMS launcher replaces it; walker (dev-tools) is the DE-agnostic fallback
    # rofimoji
    # nwg-dock-hyprland
    # nwg-drawer
    nwg-look
    # nwg-displays
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

  # FALLBACK display manager (SDDM + qylock theme): commented out while
  # dank-greeter is tried. Re-enable together with ./qylock.nix if the
  # greeter fails; disable dms-greeter.nix at the same time (they fight
  # over the login seat).
  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland.enable = true;
  # };

  services.dbus.enable = true;

  # Battery & Power
  # tlp intentionally OFF: the DMS module enables power-profiles-daemon
  # instead (see dms.nix); both managers fight over the same hardware.
  services.tlp.enable = false;
  services.logind.settings.Login.HandleLidSwitch = "suspend";

  # File system utilities
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
