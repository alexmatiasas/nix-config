_:

{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./fonts.nix
    ./hyprland.nix
    ./niri.nix
    ./dms.nix
    ./dms-greeter.nix
    # FALLBACK login (SDDM + qylock theme): kept working, commented out.
    # Re-enable if dank-greeter fails: uncomment this AND the SDDM block in
    # hyprland.nix, and disable the greeter (comment dms-greeter.nix above).
    # ./qylock.nix
    # FALLBACK desktop (KDE Plasma 6): maximum compatibility session.
    # Uncomment to install (~2GB), then pick "Plasma" at login.
    # ./plasma.nix
    ./portals.nix
    ./firmware.nix
    ./gstreamer.nix
  ];
}
