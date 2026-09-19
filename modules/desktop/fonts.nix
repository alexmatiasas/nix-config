{ pkgs, ... }:

{
  # Install my favorite fonts
  environment.systemPackages = with pkgs; [
    nerd-fonts.fira-code
  ];
}
