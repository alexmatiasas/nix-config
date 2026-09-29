# hosts/vm-gui/default.nix
# VM test for workstation profile (GUI + Hyprland + DMS).
# Keep hosts/laptop clean for future real hardware.

{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ../../profiles/workstation.nix
    ../../profiles/ml-workstation.nix
    ../../modules/core/boot.nix
    ../../modules/core/swap.nix

    ./hardware-configuration.nix
  ];

  networking.hostName = "vm-gui";

  # SPICE agent (UTM/QEMU only — never on real hardware): seamless mouse
  # grab/release with the Mac host. Clipboard sharing also requires
  # "Sharing -> Share Clipboard" enabled in the UTM VM settings, and even
  # then it only covers X11/XWayland apps — wlroots Wayland compositors
  # (Hyprland/niri) don't implement the vdagent clipboard protocol.
  # Reliable text path: SSH from Ghostty (scrollback copy just works).
  services.spice-vdagentd.enable = true;

  # EXPERIMENT: run x86_64 binaries (incl. x86_64 flatpaks) on this ARM VM
  # via qemu-user transparent emulation (binfmt_misc). Needed for trying
  # proprietary x86-only flatpaks (Zoom/Spotify/Discord) where no ARM build
  # exists. Slow by nature; promote to other hosts only if usable.
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];

  # Software rendering: the VM has no GPU.
  environment.sessionVariables = {
    LIBGL_ALWAYS_SOFTWARE = "1";
  };
}
