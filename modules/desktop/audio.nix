{ pkgs, ... }:

{
  # Pipeware enabled
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Install useful tools for audio management
  environment.systemPackages = with pkgs; [
    pavucontrol
    wireplumber
  ];
}
