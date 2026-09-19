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
    # notion

    # Deverolment
    vscode
    dbeaver-bin
    pgadmin4-desktopmode
    rstudio
    mongodb-compass

    # Multimedia and design
    vlc
    gimp
    inkscape
    blender

    # Comunication and others
    telegram-desktop
    whatsapp-for-mac
    discord
    bitwarden-desktop
    ventoy # Substitutes balena etcher

  ];
}
