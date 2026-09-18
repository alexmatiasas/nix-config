# flake.nix
{
  description = "NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    herdr.url = "github:herdrdev/herdr";
  };

  outputs =
    {
      self,
      nixpkgs,
      herdr,
      ...
    }:
    let
      system = "aarch64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # Usar nixfmt-tree corrige el comportamiento recursivo y quita los warnings
      formatter.${system} = pkgs.nixfmt-tree;

      nixosConfigurations.rpi-server = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit herdr; };
        modules = [
          ./hosts/rpi-server
        ];
      };
    };
}
