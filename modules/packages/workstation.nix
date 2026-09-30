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
    # Driven by DMS dynamic theming (enableDynamicTheming): generates
    # colors.conf/colors.lua (hypr), kitty and btop themes from wallpaper.
    # Custom templates live in modules/home/matugen (linked via HM).
    matugen
  ];
}
