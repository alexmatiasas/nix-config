{ config, pkgs, ... }:

{
  # Configure zsh as the interactive shell of the system
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  # Install the base tools of the shell that we mentioned, in the plan
  # We put it here to separate them from the "general packages"
  # git is mandatory on every machine: flakes deploy via `git pull` + rebuild
  environment.systemPackages = with pkgs; [
    git
    gh
    nh
    zinit
    starship
    atuin
    zoxide
  ];

  # Point nh at this repo so bare `nh os switch` works.
  # Derived from the user's home: no hardcoded /home paths.
  # config.users.users.alexmatias.home is hardcoded
  # to user alexmatias, this may need to be stored in a
  # var ${user}
  environment.sessionVariables = {
    NH_FLAKE = "${config.users.users.alexmatias.home}/.config/nix-config";
  };
}
