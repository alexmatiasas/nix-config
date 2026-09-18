{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Development
    neovim
    just
    shellcheck
    gh
    lazygit
    gitleaks
    git-lfs
    delta
    prek
  ];
}
