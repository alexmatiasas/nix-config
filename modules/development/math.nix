{ pkgs, ... }:

{
  system.extraDependencies = with pkgs; [
    lean
    numi
    numbat
  ];
}
