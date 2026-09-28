# flake.nix
{
  description = "NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    herdr.url = "github:herdrdev/herdr";
    dms.url = "github:AvengeMedia/DankMaterialShell";
    # DMS builds against our nixpkgs by design (mkModuleWithDmsPkgs takes
    # downstream pkgs), so a single nixpkgs covers the whole closure.
    dms.inputs.nixpkgs.follows = "nixpkgs";
    # Input name is free (repo has a dash): dmsGreeter is a valid identifier.
    dmsGreeter.url = "github:AvengeMedia/dank-greeter";
    qylock.url = "github:Darkkal44/qylock";
    # Single nixpkgs for the whole closure: our 26.05 already ships
    # quickshell, so qylock doesn't need its pinned unstable.
    qylock.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      herdr,
      dms,
      dmsGreeter,
      qylock,
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
            inherit herdr dms dmsGreeter qylock;
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
