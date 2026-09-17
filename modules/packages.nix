{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    curl
    wget

    neovim

    bat
    btop
    eza
    fd
    fzf
    ripgrep

    jq
    yq
    tree
    tmux
    zoxide

    fastfetch
    htop
    lazygit
    just
    starship
  ];
}
