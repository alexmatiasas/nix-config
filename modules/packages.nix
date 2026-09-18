{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Shell and terminal
    zsh
    zsh-completions
    tmux
    bat
    btop
    htop
    eza
    fastfetch
    fd
    fzf
    ripgrep
    tree
    yazi
    zoxide
    starship

    # Files and data
    file
    jq
    yq
    wget
    curl
    unzip
    p7zip

    # Git and workflow
    git
    git-lfs
    delta
    gh
    lazygit
    gitleaks
    prek

    # General development
    neovim
    just
    shellcheck
  ];
}
