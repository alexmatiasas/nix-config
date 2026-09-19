{ pkgs, ... }:

{
  # Enable the desktop environment GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Install a minimal set of apps to avoid the bloatware of GNOME
  environment.systemPackages = with pkgs; [
    gnome-terminal
    gnome-control-center
    nautilus
  ];
}
