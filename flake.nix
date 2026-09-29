# flake.nix
{
  description = "NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    herdr.url = "github:herdrdev/herdr";
    # Lockstep with nixpkgs 26.05: mismatched HM/nixpkgs releases break subtly.
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Pinned stable (not main): declarative flatpak manager with
    # uninstall-on-remove (true single source of truth).
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
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
      home-manager,
      nix-flatpak,
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
            inherit
              herdr
              nix-flatpak
              dms
              dmsGreeter
              qylock
              ;
          };
          modules = [
            ./hosts/${host}
            home-manager.nixosModules.home-manager
            {
              # HM available on every host; users are defined per-profile
              # (workstation only, for now). Collisions with pre-existing
              # dotfiles back up instead of failing the switch.
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "hm-backup";
              };
            }
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
