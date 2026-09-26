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
    # Prebuilt Noctalia binaries: skip compiling the shell locally
    # (matters a lot on the weak aarch64 VM).
    settings.extra-substituters = [
      "https://noctalia.cachix.org"
    ];
    settings.extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
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
