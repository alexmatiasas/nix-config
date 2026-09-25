{ pkgs, ... }:

{
  services.flatpak.enable = true;

  # systemd.services.flatpak-install-apps = {
  #   description = "Install essential Flatpak applications";
  #   after = [ "network-online.target" ];
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = pkgs.writeShellScript "flatpak-install-script" ''
  #       ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  #
  #       # Instalación explícita: Sin variables, sin bucles, sin errores de interpolación
  #       ${pkgs.flatpak}/bin/flatpak install -y flathub com.spotify.Client
  #       ${pkgs.flatpak}/bin/flatpak install -y flathub com.discordapp.Discord
  #       ${pkgs.flatpak}/bin/flatpak install -y flathub com.zoom.zoom
  #       ${pkgs.flatpak}/bin/flatpak install -y flathub com.slack.Slack
  #       ${pkgs.flatpak}/bin/flatpak install -y flathub com.dropbox.Dropbox
  #       ${pkgs.flatpak}/bin/flatpak install -y flathub com.microsoft.Teams
  #       ${pkgs.flatpak}/bin/flatpak install -y flathub com.obsproject.Studio
  #       ${pkgs.flatpak}/bin/flatpak install -y flathub com.usebottles.bottles
  #       ${pkgs.flatpak}/bin/flatpak install -y flathub org.localsend.localsend_app
  #       ${pkgs.flatpak}/bin/flatpak install -y flathub org.mozilla.thunderbird_esr
  #       ${pkgs.flatpak}/bin/flatpak install -y flathub io.github.jeffshee.Hidamari
  #       ${pkgs.flatpak}/bin/flatpak install -y flathub org.kde.okular
  #       ${pkgs.flatpak}/bin/flatpak install -y flathub com.calibre_ebook.calibre
  #       ${pkgs.flatpak}/bin/flatpak install -y flathub org.mozilla.firefox
  #       ${pkgs.flatpak}/bin/flatpak install -y flathub com.getpostman.Postman
  #     '';
  #   };
  # };
}
