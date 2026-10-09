{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Development
    neovim
    just
    shellcheck
    # gh lives in programs/shell.nix (needed on servers too); not duplicated here.
    sql-formatter
    sql-migrate
    lazygit
    gitleaks
    walker
    quickshell
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
    # No restic: kopia won the backup decision (see services/backups.nix).
    # Editor LSP runtimes (Mason downloads the servers, Nix provides what
    # Mason can't): nixd binary itself, JDK for Mason's ltex-ls (Java bytecode
    # is portable, it just needs a runtime in PATH).
    nixd
    jdk
  ];
}
