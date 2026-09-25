{ pkgs, ... }:

{
  # Install restic tool
  environment.systemPackages = with pkgs; [
    restic
  ];

  # Configuration of a timer for systemd for automatic backups
  systemd.services.restic-backup = {
    description = "Automatic Backup of Projects and Documents";
    after = [ "network-online.target" ];
    wantedBy = [ "timers.target" ];
    serviceConfig = {
      Type = "oneshot";
      # Executes the backup. NOTE: requires that the repository be initializated at home/
      ExecStart = "${pkgs.restic}/bin/restic backup /home/alexmatias/projects /home/alexmatias/Documents";
    };
  };

  systemd.timers.restic-backup = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # Executes the backup every day at 3:00 AM
      OnCalendar = "*-*-* 03:00:00";
      Persistent = true; # If machine is off, then when restarts
    };
  };
}
