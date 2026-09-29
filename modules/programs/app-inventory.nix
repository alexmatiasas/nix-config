{ nix-flatpak, lib, pkgs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;

  # THE desktop app inventory: one entry per app, Nix generates both the
  # native installs and the flatpak list from here. Single source of truth.
  #
  # Schema per entry:
  #   nix     = nixpkgs package (or null) — preferred: ~0.5s startup measured.
  #   flatpak = null, or { id, arches } — Flathub ID + arches it SHIPS for
  #             (verified via Flathub bundle metadata, NOT assumed).
  #   status  = "verified" | "pending-dry-build" — pending entries MUST pass
  #             `dry-build` on the target arch before counting on them.
  #
  # Rules:
  # - Exactly one backend active per app per arch (never nix+flatpak dupes).
  # - ARM without any build -> web app in native Firefox (Zoom/Teams/Slack/
  #   Spotify/Discord have no ARM Linux builds anywhere).
  # - Removing an entry uninstalls it (nix-flatpak convergent management).
  apps = [
    # --- Native (verified running on vm-gui aarch64) ---
    {
      name = "firefox";
      nix = pkgs.firefox;
      flatpak = null;
      status = "verified";
    }

    # --- Native (pending ARM dry-build; fallback documented below) ---
    {
      name = "thunderbird";
      nix = pkgs.thunderbird;
      flatpak = null; # was org.mozilla.Thunderbird (x86_64-only flatpak)
      status = "pending-dry-build"; # if it fails: restore flatpak x86 entry
    }
    {
      name = "obs-studio";
      nix = pkgs.obs-studio;
      flatpak = null; # was com.obsproject.Studio (x86_64-only flatpak)
      status = "pending-dry-build"; # if it fails: restore flatpak x86 entry
    }

    # --- Flatpak, universal (verified installed on vm-gui aarch64) ---
    {
      name = "localsend";
      nix = null;
      flatpak = {
        id = "org.localsend.localsend_app";
        arches = [
          "aarch64-linux"
          "x86_64-linux"
        ];
      };
      status = "verified";
    }
    {
      name = "hidamari";
      nix = null;
      flatpak = {
        id = "io.github.jeffshee.Hidamari";
        arches = [
          "aarch64-linux"
          "x86_64-linux"
        ];
      };
      status = "verified";
    }
    {
      name = "okular";
      nix = null; # nixpkgs okular exists; flatpak chosen (verified working)
      flatpak = {
        id = "org.kde.okular";
        arches = [
          "aarch64-linux"
          "x86_64-linux"
        ];
      };
      status = "verified";
    }
    {
      name = "calibre";
      nix = null; # nixpkgs calibre exists; flatpak chosen (verified working)
      flatpak = {
        id = "com.calibre_ebook.calibre";
        arches = [
          "aarch64-linux"
          "x86_64-linux"
        ];
      };
      status = "verified";
    }
    {
      name = "postman";
      nix = null; # proprietary, no ARM nixpkgs build
      flatpak = {
        id = "com.getpostman.Postman";
        arches = [
          "aarch64-linux"
          "x86_64-linux"
        ];
      };
      status = "verified";
    }

    # --- Flatpak, x86_64-only (verified absent on Flathub ARM) ---
    {
      name = "spotify";
      nix = null; # nixpkgs spotify is x86_64-only too; ARM -> web app
      flatpak = {
        id = "com.spotify.Client";
        arches = [ "x86_64-linux" ];
      };
      status = "verified";
    }
    {
      name = "discord";
      nix = null; # nixpkgs discord is x86_64-only too; ARM -> web app
      flatpak = {
        id = "com.discordapp.Discord";
        arches = [ "x86_64-linux" ];
      };
      status = "verified";
    }
    {
      name = "zoom";
      nix = null; # no ARM build anywhere; ARM -> web app
      flatpak = {
        id = "us.zoom.Zoom";
        arches = [ "x86_64-linux" ];
      }; # NOTE: com.zoom.Zoom is a wrong ID that never existed
      status = "verified";
    }
    {
      name = "bottles";
      nix = null; # Wine is x86 by nature; ARM -> n/a
      flatpak = {
        id = "com.usebottles.bottles";
        arches = [ "x86_64-linux" ];
      };
      status = "verified";
    }

    # --- Triage backlog (commented until verified per app) ---
    # Former modules/programs/desktop-apps.nix content, unverified.
    # To promote: uncomment ONE, dry-build on target arch, set status.
    # { name = "chrome"; nix = pkgs.google-chrome; flatpak = null; status = "pending-dry-build"; }
    # { name = "brave"; nix = pkgs.brave; flatpak = null; status = "pending-dry-build"; }
    # { name = "obsidian"; nix = pkgs.obsidian; flatpak = null; status = "pending-dry-build"; }
    # { name = "zettlr"; nix = pkgs.zettlr; flatpak = null; status = "pending-dry-build"; } # known broken on aarch64
    # { name = "zotero"; nix = pkgs.zotero; flatpak = null; status = "pending-dry-build"; }
    # { name = "anki"; nix = pkgs.anki; flatpak = null; status = "pending-dry-build"; }
    # { name = "notion"; nix = null; flatpak = null; status = "pending-dry-build"; } # no native, no flatpak -> web app?
    # { name = "vscode"; nix = pkgs.vscode; flatpak = null; status = "pending-dry-build"; }
    # { name = "dbeaver"; nix = pkgs.dbeaver-bin; flatpak = null; status = "pending-dry-build"; }
    # { name = "pgadmin"; nix = pkgs.pgadmin4-desktopmode; flatpak = null; status = "pending-dry-build"; }
    # { name = "vlc"; nix = pkgs.vlc; flatpak = null; status = "pending-dry-build"; }
    # { name = "gimp"; nix = pkgs.gimp; flatpak = null; status = "pending-dry-build"; }
    # { name = "inkscape"; nix = pkgs.inkscape; flatpak = null; status = "pending-dry-build"; }
    # { name = "blender"; nix = pkgs.blender; flatpak = null; status = "pending-dry-build"; }
    # { name = "telegram"; nix = pkgs.telegram-desktop; flatpak = null; status = "pending-dry-build"; }
    # { name = "whatsapp"; nix = null; flatpak = null; status = "pending-dry-build"; } # whatsapp-electron? verify ID first
    # { name = "bitwarden"; nix = pkgs.bitwarden-desktop; flatpak = null; status = "pending-dry-build"; }
    # { name = "ventoy"; nix = pkgs.ventoy; flatpak = null; status = "pending-dry-build"; } # insecure version pin needed (see core/nix.nix)

    # --- Never on Flathub at all (do not add as flatpak, ever) ---
    # com.slack.Slack (withdrawn), com.dropbox.Dropbox (never official),
    # com.microsoft.Teams (discontinued on Linux).
  ];

  withNix = lib.filter (a: a.nix != null) apps;
  withFlatpak = lib.filter (
    a: a.flatpak != null && lib.elem system a.flatpak.arches
  ) apps;
in
{
  imports = [ nix-flatpak.nixosModules.nix-flatpak ];

  environment.systemPackages = map (a: a.nix) withNix;

  services.flatpak = {
    enable = true;
    packages = map (a: a.flatpak.id) withFlatpak;
    # Update everything on activation. Retry-with-backoff on flaky networks
    # is built in (restartOnFailure defaults). Manual installs are left
    # alone (uninstallUnmanaged stays false) — e.g. x86_64 emulation tests.
    update.onActivation = true;
  };
}
