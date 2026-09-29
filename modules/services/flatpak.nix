{ nix-flatpak, lib, pkgs, ... }:

let
  # Flatpak inventory, verified against Flathub's arch metadata
  # (bundle: app/<id>/<arch>/stable).
  #
  # Two tiers: universal apps install everywhere; x86_64-only apps are gated
  # by hostPlatform so the same config works on ARM VMs and the future
  # x86_64 laptop without manual triage per machine.
  #
  # Single source of truth per app: if it lives in nixpkgs
  # (see modules/packages/gui-apps.nix), it does NOT live here, and vice
  # versa. Removing an ID from these lists UNINSTALLS it (nix-flatpak
  # convergent management) — unlike the old hand-rolled install service.
  #
  # Excluded entirely (don't exist on Flathub at all): com.slack.Slack
  # (withdrawn), com.dropbox.Dropbox (never official), com.microsoft.Teams
  # (discontinued on Linux), com.zoom.Zoom (wrong ID; real one is us.zoom.Zoom).
  flatpakAppsCommon = [
    "org.localsend.localsend_app"
    "io.github.jeffshee.Hidamari"
    "org.kde.okular"
    "com.calibre_ebook.calibre"
    "com.getpostman.Postman"
  ];

  # Verified x86_64-only on Flathub. ARM alternatives:
  # - OBS Studio -> pkgs.obs-studio (native, in gui-apps.nix)
  # - Thunderbird -> pkgs.thunderbird (native, in gui-apps.nix)
  # - Spotify / Discord / Zoom / Bottles -> no ARM build; web apps on ARM,
  #   and on x86_64 either these flatpaks or the WARNING below about emulation.
  # EXPERIMENT (not declared here): x86_64 flatpaks on ARM via qemu-user
  # binfmt (see vm-gui host). Manual only:
  #   sudo flatpak install --arch=x86_64 flathub us.zoom.Zoom
  # Keep them OUT of this list until proven usable (a failing ref would retry
  # forever via restartOnFailure).
  flatpakAppsX86 = [
    "com.spotify.Client"
    "com.discordapp.Discord"
    "us.zoom.Zoom"
    "com.obsproject.Studio"
    "com.usebottles.bottles"
    "org.mozilla.Thunderbird"
  ];

  flatpakApps =
    flatpakAppsCommon
    ++ lib.optionals pkgs.stdenv.hostPlatform.isx86_64 flatpakAppsX86;
in
{
  imports = [ nix-flatpak.nixosModules.nix-flatpak ];

  services.flatpak = {
    enable = true;
    packages = flatpakApps;
    # Update everything on activation (every switch/boot): install-only
    # freezes versions forever. Retry-with-backoff on flaky networks is
    # built in (restartOnFailure defaults).
    update.onActivation = true;
    # Only declared refs are managed; manual installs (e.g. the x86_64
    # emulation experiment) are left alone. uninstallUnmanaged stays false.
  };
}
