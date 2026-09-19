{ pkgs, ... }:

{
  # Pantheon requiere un gestor de ventanas y servicios específicos
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true; # Pantheon funciona mejor con LightDM

  # Instalamos el escritorio Pantheon y sus componentes base
  environment.systemPackages = with pkgs; [
    pantheon
    pantheon.epiphany
    pantheon.mutter
    pantheon.granite
    nautilus
  ];
}
