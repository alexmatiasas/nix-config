{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Modern CLI Tools
    eza
    bat
    fd
    fzf
    ripgrep
    tree
    yazi
    fastfetch
    glow
    duckdb
    httpie
    typos
  ];
}
