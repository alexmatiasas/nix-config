# flake.nix
{
  description = "NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs =
    {
      self,
      nixpkgs,
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
        modules = [
          ./hosts/rpi-server
        ];
      };
    };
}
