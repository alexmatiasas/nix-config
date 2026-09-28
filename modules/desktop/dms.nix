{ dms, ... }:

{
  imports = [ dms.nixosModules.dank-material-shell ];

  programs.dank-material-shell = {
    enable = true;
    # Package defaults to dms-shell built from source against our nixpkgs
    # (no null-trap like noctalia had). First switch compiles Go: slow once.
    # Autostart is NOT via systemd here: greetd-launched sessions don't
    # guarantee graphical-session.target (proven: only the uwsm-managed SDDM
    # session activated it). Instead autostart deterministically from Hyprland:
    #   exec-once = dms run --session
    # (one mechanism only: enabling systemd.enable alongside exec-once would
    # launch two instances).
    systemd.enable = false;
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
