{ pkgs, lib, ... }:

let
  # Inventory of Flatpak apps, verified against Flathub's arch metadata
  # (bundle: app/<id>/<arch>/stable) on 2026-09-28.
  #
  # Two tiers: universal apps install everywhere; x86_64-only apps are gated
  # by hostPlatform so the same config works on ARM VMs and the future
  # x86_64 laptop without manual triage per machine.
  #
  # Excluded entirely (don't exist on Flathub at all): com.slack.Slack
  # (withdrawn), com.dropbox.Dropbox (never official), com.microsoft.Teams
  # (discontinued on Linux), com.zoom.Zoom (wrong ID; real one is us.zoom.Zoom).
  # Single source of truth per app: if it lives in nixpkgs (see
  # modules/packages/gui-apps.nix), it does NOT live here, and vice versa.
  # Native proven ~0.5s startup vs 30-180s sandboxed on this VM.
  flatpakAppsCommon = [
    "org.localsend.localsend_app"
    "io.github.jeffshee.Hidamari"
    "org.kde.okular"
    "com.calibre_ebook.calibre"
    "com.getpostman.Postman"
  ];

  # Verified x86_64-only on Flathub. ARM alternatives:
  # - OBS Studio -> pkgs.obs-studio (native, aarch64 OK)
  # - Thunderbird -> pkgs.thunderbird (native, aarch64 OK)
  # - Spotify / Discord / Zoom / Bottles -> no ARM build; use web apps
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
  services.flatpak.enable = true;

  systemd.services.flatpak-install-apps = {
    description = "Install essential Flatpak applications";
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
    };
    script = ''
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    ''
    # Failures are ECHOED, not swallowed: a missing/arch-mismatched app shows
    # as FLATPAK-FAILED in the journal without failing the whole switch.
    + lib.concatMapStrings (
      app: "        ${pkgs.flatpak}/bin/flatpak install -y flathub ${app} || echo \"FLATPAK-FAILED: ${app}\"\n"
    ) flatpakApps
    # Keep installed apps current on every boot (install -y alone skips
    # what's already installed, freezing versions forever).
    + ''
      ${pkgs.flatpak}/bin/flatpak update -y || echo "FLATPAK-UPDATE-FAILED"
    '';
  };
}
