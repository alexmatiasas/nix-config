{ pkgs, ... }:

{
  # Configure zsh as the interactive shell of the system
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  # Install the base tools of the shell that we mentioned, in the plan
  # We put it here to separate them from the "general packages"
  environment.systemPackages = with pkgs; [
    starship
    atuin
    zoxide
}
