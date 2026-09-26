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

      mkNixosSystem =
        host:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit herdr noctalia;
          };
          modules = [
            ./hosts/${host}
          ];
        };
    in
    {
      formatter.${system} = pkgs.nixfmt-tree;

      nixosConfigurations = {
        "rpi-server" = mkNixosSystem "rpi-server";
        laptop = mkNixosSystem "laptop";
        "vm-gui" = mkNixosSystem "vm-gui";
      };
    };
}
