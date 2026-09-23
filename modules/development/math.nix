{ pkgs, ... }:

{
  system.extraDependencies = with pkgs; [
    lean
  ];
}
