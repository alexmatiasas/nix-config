{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # Browsers
    google-chrome
    brave

    # Productivity and notes
    obsidian
    zettlr
    zotero
    anki
    notion

    # Development
    vscode
    dbeaver-bin
    pgadmin4-desktopmode
    # rstudio # there was a problem with this package, to check it out
    # mongodb-compass # not supported for aarch64-linux

    # Multimedia and design
    vlc
    gimp
    inkscape
    blender
    spotify

    # Comunication and others
    telegram-desktop
    whatsapp-electron
    discord
    bitwarden-desktop
    ventoy # Substitutes balena etcher

  ];
}
