{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fnm
    pnpm
    nodejs
    husky
  ];
}
