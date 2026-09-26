# flake.nix
{
  description = "NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    herdr.url = "github:herdrdev/herdr";
    # Pinned to the /cachix branch: always points at the latest commit
    # with prebuilt binaries, so the VM never compiles Noctalia locally.
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
  };

  outputs =
    {
      self,
      nixpkgs,
      herdr,
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
