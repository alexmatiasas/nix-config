# flake.nix
{
  description = "NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.rpi-server = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";

      modules = [
        ./hosts/rpi-server
      ];
    };
  };
}
