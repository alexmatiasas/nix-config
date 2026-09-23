# flake.nix
{
  description = "NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    herdr.url = "github:herdrdev/herdr";
    qylock.url = "github:Darkkal44/qylock";
  };

  outputs =
    {
      self,
      nixpkgs,
      herdr,
      qylock,
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
          # qylock.nixosModules.default
          # ({ pkgs, ... }: {
          #   services.displayManager.sddm.enable = true;
          #   services.displayManager.sddm.wayland.enable = true;
          #
          #   programs.qylock = {
          #     enable = true;
          #     theme = "dog-samurai"; # any directory name under themes/
          #     sddm.enable = true; # installs theme + sets it active (default)
          #     quickshell.enable = true; # adds `qylock-lock` to PATH (default)
          #
          #     # Optional per-theme tweaks (replaces the interactive prompts):
          #     themeOptions = {
          #       terraria.backgroundMode = "time"; # time | random | static
          #       Genshin.backgroundMode = "time";
          #       clockwork.orbital = {
          #         themeMode = "dark";
          #         enableWindup = true;
          #       };
          #       osu.gameMode = "game"; # menu | game
          #     };
          #   };
          # })
        ];
      };
    };
}
