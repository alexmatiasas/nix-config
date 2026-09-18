{ pkgs, herdr, ... }:

{
  environment.systemPackages = [
    herdr.packages.${pkgs.system.hostname}.default
  ];
}
