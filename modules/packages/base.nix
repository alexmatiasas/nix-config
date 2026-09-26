{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core utils (shared by all profiles via modules/packages)
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
    chezmoi
  ];
}
