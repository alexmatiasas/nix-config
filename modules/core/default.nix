_:

{

  imports = [
    ./boot.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./security.nix
    ./users.nix
    ./swap.nix
  ];

  system.stateVersion = "26.05";
}
