{ pkgs, ... }:

{
  services.tailscale.enable = true;

  # Install the CLI for the first time to do 'tailscale up'
  environment.systemPackages = with pkgs; [
    tailscale
  ];
}
