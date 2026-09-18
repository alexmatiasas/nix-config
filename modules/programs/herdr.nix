{ pkgs, herdr, ... }:

{
  environment.systemPackages = [
    (herdr.packages.${pkgs.system} or herdr.packages.x86_64-linux or herdr.packages.aarch64-linux)
  ];
}
