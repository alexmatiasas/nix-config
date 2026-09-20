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

        # Instalación explícita: Sin variables, sin bucles, sin errores de interpolación
        ${pkgs.flatpak}/bin/flatpak install -y flathub com.spotify.Client
        ${pkgs.flatpak}/bin/flatpak install -y flathub com.discordapp.Discord
        ${pkgs.flatpak}/bin/flatpak install -y flathub com.zoom.zoom
        ${pkgs.flatpak}/bin/flatpak install -y flathub com.slack.Slack
        ${pkgs.flatpak}/bin/flatpak install -y flathub com.dropbox.Dropbox
        ${pkgs.flatpak}/bin/flatpak install -y flathub com.microsoft.Teams
      '';
    };
  };
}
