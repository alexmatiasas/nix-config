{ qylock, ... }:

{
  imports = [ qylock.nixosModules.default ];

  programs.qylock = {
    enable = true;
    # Any directory name under qylock's themes/ (see its gallery).
    # dog-samurai was your earlier pick; switch freely, it's one word.
    theme = "dog-samurai";
    # sddm.enable = true installs the theme + sets it active (default).
    # quickshell.enable = true adds `qylock-lock` to PATH (default).
    # Bind it in Hyprland for the quickshell lockscreen, e.g.:
    #   bind = SUPER, L, exec, qylock-lock
  };
}
