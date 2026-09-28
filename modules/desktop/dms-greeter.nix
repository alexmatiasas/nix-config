{ config, dmsGreeter, ... }:

{
  imports = [ dmsGreeter.nixosModules.default ];

  programs.dms-greeter = {
    enable = true;
    compositor.name = "hyprland";
    # Syncs this user's DMS theme/wallpaper into the login screen.
    # Derived from the user definition: no hardcoded /home paths.
    configHome = config.users.users.alexmatias.home;
  };
}
