{ pkgs, ... }:

{
  # Enable Bluetooth service
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Install the graphic manager of Bluetooth
  environment.systemPackages = with pkgs; [
    blueman
  ];
}
