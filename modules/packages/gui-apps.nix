{ pkgs, ... }:

{
  # Curated GUI apps installed NATIVELY from nixpkgs.
  #
  # Single source of truth per app: anything listed here must NOT be in
  # modules/services/flatpak.nix, and vice versa. Rationale (measured on
  # vm-gui 2026-09-28): native Firefox starts in ~0.5s vs 30-180s sandboxed.
  #
  # Triage rule for new entries: confirm the aarch64 build exists
  # (dry-build on the VM) before adding. Proprietary x86_64-only apps
  # (Spotify/Discord/Zoom) stay out: web apps on ARM, flatpak on x86_64.
  environment.systemPackages = with pkgs; [
    # Batch 1 (pending VM dry-build verification):
    thunderbird
    obs-studio
  ];
}
