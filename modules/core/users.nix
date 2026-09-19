{ pkgs, ... }: {
  users.users.alexmatias = {
    isNormalUser = true;
    description = "Alex Matías";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEvriL6yohuz3kNEPP2QQ/PungiDGgqIyTX4iUfLzl92 alejandromatiasas@gmail.com"
    ];
  };
}
