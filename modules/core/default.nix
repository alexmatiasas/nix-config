_:

{
  # Enable flatpak
  services.flatpak.enable = true;

  imports = [
    ./boot.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./security.nix
    ./users.nix
  ];

  system.stateVersion = "26.05";
}
