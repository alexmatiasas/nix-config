{ noctalia, pkgs, ... }:

{
  imports = [ noctalia.nixosModules.default ];

  programs.noctalia = {
    enable = true;
    # The flake default leaves package = null (nothing installed).
    # Point it at the input's package or the service/binary won't exist.
    package = noctalia.packages.${pkgs.system}.default;
    # Enables NetworkManager, Bluetooth, UPower and a power-profile service.
    # (NM + BT already on; this adds UPower + power-profiles-daemon.)
    recommendedServices.enable = true;
    # User systemd service so Noctalia autostarts with the Hyprland session.
    systemd.enable = true;
    # Anchor to the uwsm-provided target, NOT graphical-session.target:
    # SDDM offers both plain and uwsm-managed Hyprland sessions, and only
    # the uwsm one activates hyprland-session.target. Log in via
    # "Hyprland (uwsm-managed)" or this service never triggers.
    systemd.target = "hyprland-session.target";
    # NOTE: visual settings (theme, wallpaper, widgets) are NOT nix options
    # here — that is the Home Manager module's job. Configure them once in
    # the Noctalia settings UI (writes ~/.config/noctalia/); consider moving
    # that file under chezmoi later if you want it versioned.
  };

  # power-profiles-daemon (from recommendedServices) replaces tlp:
  # the two power managers fight over the same hardware controls.
  services.tlp.enable = false;
}
