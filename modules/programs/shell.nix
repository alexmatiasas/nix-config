{ pkgs, ... }:

{
  # Configura zsh como el shell interactivo del sistema
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  # Instalamos las herramientas base de la shell que mencionamos en el plan
  # Las ponemos aquí para separarlas de los "paquetes generales"
  environment.systemPackages = with pkgs; [
    starship
    atuin
    zoxide
    fnm
    pnpm
  ];
}
