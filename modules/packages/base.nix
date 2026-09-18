{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core utils
    zsh
    zsh-completions
    tmux
    git
    curl
    wget
    file
    jq
    yq
    unzip
    p7zip
    htop
    btop
  ];
}
