_:

{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    optimise.automatic = true;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs.config = {
    allowUnsupportedSystem = true;
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-41.9.1"
      "ventoy-1.1.12"
    ];
  };
}
