{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lean
    numi
    numbat
  ];
}
