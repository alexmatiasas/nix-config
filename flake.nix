# flake.nix
{
  description = "NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    herdr.url = "github:herdrdev/herdr";
    qylock.url = "github:Darkkal44/qylock";
    noctalia.url = "github:noctalia-dev/noctalia";
  };

  outputs =
    {
      self,
      nixpkgs,
      herdr,
      qylock,
      noctalia,
      ...
    }:
    let
      system = "aarch64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # Use nixfmt-tree to fix the recursive behavior and remove warnings
      formatter.${system} = pkgs.nixfmt-tree;

      nixosConfigurations.rpi-server = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit herdr noctalia; };
        modules = [
          ./hosts/rpi-server
        ];
      };

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit herdr noctalia; };
        modules = [
          ./hosts/laptop
        ];
      };
    };
}
