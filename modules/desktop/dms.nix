{ dms, ... }:

{
  imports = [ dms.nixosModules.dank-material-shell ];

  programs.dank-material-shell = {
    enable = true;
    # Package defaults to dms-shell built from source against our nixpkgs
    # (no null-trap like noctalia had). First switch compiles Go: slow once.
    systemd.enable = true;
    # Default anchor is graphical-session.target, proven active in the
    # uwsm-managed SDDM... now greetd session. Revisit if DMS doesn't start.
    # Feature widgets below pull their runtime deps automatically.
    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    # Declarative plugins (the programmable playground):
    # plugins.<Name> = { src = pkgs.fetchFromGitHub { ... }; settings = { ... }; };
    plugins = { };
  };

  # DMS does not enable UPower itself (only PPD/accounts/geoclue/polkit);
  # the battery widget needs it. tlp stays OFF: PPD owns power management.
  services.upower.enable = true;
}
