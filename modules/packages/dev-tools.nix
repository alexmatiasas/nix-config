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
    git-absorb
    git-town
    delta
    prek
    commitizen
    commitlint
    pre-commit
    vale
    yamllint
    sops
    restic
  ];
}
