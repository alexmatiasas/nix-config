{ pkgs, ... }:

{
  services.flatpak.enable = true;

  systemd.services.flatpak-install-apps = {
    description = "Install essential Flatpak applications";
    after = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "flatpak-install-script" ''
        ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

        # Cambiamos 'app' por 'FP_APP' para evitar colisiones de PID
        FP_APPS=(
          "com.spotify.Client"
          "com.discordapp.Discord"
          "com.zoom.zoom"
          "com.slack.Slack"
          "com.dropbox.Dropbox"
          "com.microsoft.Teams"
        )

        for FP_APP in "$${FP_APPS[@]}"; do
          ${pkgs.flatpak}/bin/flatpak install -y flathub "$$FP_APP"
        done
      '';
    };
  };
}
