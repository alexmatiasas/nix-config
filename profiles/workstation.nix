{ noctalia, ... }:

{
  imports = [
    ../modules/core/default.nix
    ../modules/services/tailscale.nix
    ../modules/development/default.nix
    ../modules/desktop/default.nix
    noctalia.nixosModules.default
  ];
}
