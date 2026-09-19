_:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config = {
    allowUnsupportedSystem = true;
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-41.9.1"
    ];
  };
}
