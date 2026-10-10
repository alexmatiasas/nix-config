# Yazi config, vendored from chezmoi dot_config/yazi/.
# Active flavor is nord (vendored, readonly_ prefixes stripped). The other
# flavors in package.toml (kanagawa-dragon, synthwave84, sequoia) download
# on demand: `ya pack -a` (needs network, once).
{
  home-manager.users.alexmatias = {
    xdg.configFile."yazi" = {
      source = ./yazi;
      recursive = true;
    };
  };
}
