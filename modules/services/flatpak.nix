{ pkgs, lib, ... }:

let
  # Inventory of Flatpak apps. The script is generated with a loop in Nix
  # (lib.concatMapStrings), so the install pattern is not repeated for each app
  # and nixfmt never sees conflicting Bash syntax.
  #
  # NOTE: com.slack.Slack, com.dropbox.Dropbox and com.microsoft.Teams
  # is excluded because they do not exist in Flathub (Slack withdrew its flatpak,
  # Dropbox never had an official one, Teams was discontinued on Linux).
  # These three were the ones that caused the switch to fail with exit 4.
  flatpakApps = [
    "com.spotify.Client"
    "com.discordapp.Discord"
    "com.zoom.Zoom"
    "com.obsproject.Studio"
    "com.usebottles.bottles"
    "org.localsend.localsend_app"
    "org.mozilla.Thunderbird"
    "io.github.jeffshee.Hidamari"
    "org.kde.okular"
    "com.calibre_ebook.calibre"
    "org.mozilla.firefox"
    "com.getpostman.Postman"
  ];
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
    + lib.concatMapStrings (
      app: "        ${pkgs.flatpak}/bin/flatpak install -y flathub ${app} || true\n"
    ) flatpakApps;
  };
}
