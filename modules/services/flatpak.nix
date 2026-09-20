{pkgs, ...}:

{
  # Enable flatpak
  services.flatpak.enable = true;
  
systemd.services.flatpak-install-apps = {
    description = "Install essential Flatpak applications";
    after = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      # Script que añade el repo e instala las apps de tu lista
      ExecStart = pkgs.writeShellScript "flatpak-install-script" ''
        ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
        
        # Lista de apps imprescindibles (Sustituto de Brew Casks)
        APPS=(
          "com.spotify.Client"
          "com.discordapp.Discord"
          "com.zoom.zoom"
          "com.slack.Slack"
          "com.dropbox.Dropbox"
          "com.microsoft.Teams"
        )
        
        for app in "\${APPS[@]}"; do
          ${pkgs.flatpak}/bin/flatpak install -y flathub "\$app"
        done
      '';
    };
  };
}
