{ pkgs, ... }:

{
  # Pantheon requiere un gestor de ventanas y servicios específicos
  services.xserver.enable = true;
  services.desktopManager.pantheon.enable = true;
  services.xserver.displayManager.lightdm.greeters.pantheon.enable = false;
  services.xserver.displayManager.lightdm.enable = true;
  services.pantheon.apps.enable = false;

  # Instalamos el escritorio Pantheon y sus componentes base
  environment.systemPackages = with pkgs; [
    pantheon-tweaks
    nautilus
  ];
}
