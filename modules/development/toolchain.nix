{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    clang
    clang-tools
    cmake
    ninja
    pkg-config
    gnumake
  ];
}
