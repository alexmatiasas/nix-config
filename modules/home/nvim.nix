# LazyVim starter, vendored verbatim from chezmoi dot_config/nvim
# (minus an accidental empty git skeleton under lua/config/, dropped).
#
# Nested inside home-manager.users like the rest of modules/home/*:
# this file is a NixOS module, NOT a Home Manager module.
# Static tree (nothing writes into ~/.config/nvim at runtime: lazy.nvim
# state lives in ~/.local/share/nvim, Mason under ~/.local/share/nvim),
# so a plain read-only store symlink is correct here — unlike hypr/,
# matugen/ and btop/, which need mkOutOfStoreSymlink for generated files.
{
  home-manager.users.alexmatias = {
    xdg.configFile."nvim".source = ./nvim;
  };
}
