{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Development
    neovim
    just
    shellcheck
    gh
    sql-formatter
    sql-migrate
    lazygit
    gitleaks
    git-lfs
    git-absorb
    git-town
    delta
    prek
    R
    docker
    docker-compose
    ollama
    commitizen
    commitlint
    pre-commit
    vale
    yamllint
    sops
    restic
  ];
}
