{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core utils
    zsh
    zsh-completions
    zinit
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

    # Visual & Aesthetics (The "Rice" Base)
    # Compatibility: All aarch64 / x86_64
    font-awesome # Icons for Waybar
    catppuccin-gtk # System-wide theme
    papirus-icon-theme # High-quality icons
    swww # High-perf wallpaper daemon (animated)
    mako # Minimalist notification daemon

    # Waybar & Desktop Dependencies
    pamixer # Audio control (CLI)
    pavucontrol # Audio control (GUI)
    blueman # Bluetooth manager
    wttrbar # Weather for Waybar
  ];
}
