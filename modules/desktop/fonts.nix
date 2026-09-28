{ pkgs, ... }:

{
  # Install my favorite fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.noto
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    font-awesome
    # Required by DankMaterialShell + dank-greeter iconography.
    # Without it their Quickshell scenes can render broken/blank.
    material-symbols
  ];
}
