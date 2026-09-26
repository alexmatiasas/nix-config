_:

{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/server.nix
    # Bootloader for current VM (UEFI + vfat /boot). On a physical Raspberry Pi, replace it with
    # boot.loader.generic-extlinux-compatible.enable = true
    ../../modules/core/boot.nix
  ];

  networking.hostName = "rpi-server";

  # zram instead of swapfile: swap on file burns the SD card.
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };
}
