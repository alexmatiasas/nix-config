{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core utils
    zsh
    zsh-completions
    zinit
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
    chezmoi
  ];
}
