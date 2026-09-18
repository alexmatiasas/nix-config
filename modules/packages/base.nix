{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core utils
    zsh
    zsh-completions
    tmux
    herdr
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
