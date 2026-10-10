# Yazi config, vendored from chezmoi dot_config/yazi/.
# Active flavor is nord (vendored, readonly_ prefixes stripped). The other
# flavors in package.toml (kanagawa-dragon, synthwave84, sequoia) download
# on demand: `ya pack -a` (needs network, once).
#
# Out-of-store symlink like the rest of home/*: live edits, git-reviewed.
{ config, ... }:

let
  home = config.users.users.alexmatias.home;
in
{
  home-manager.users.alexmatias = { config, ... }: {
    xdg.configFile."yazi".source =
      config.lib.file.mkOutOfStoreSymlink "${home}/.config/nix-config/modules/home/yazi";
  };
}
