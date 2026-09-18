_:

{
  services.openssh = {
    enable = true;

    settings = {
      PermitRootLogin = "no";

      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PubkeyAuthentication = true;
      PermitEmptyPasswords = false;

      AllowUsers = [ "alexmatias" ];

      MaxAuthTries = 3;

      IgnoreRhosts = true;
      HostbasedAuthentication = false;

      X11Forwarding = false;
    };
  };
}
