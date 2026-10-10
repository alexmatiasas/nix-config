# Shell home files (Linux static renders of the chezmoi .tmpl sources).
# zinit keeps its auto-bootstrap: first login downloads plugins if absent.
#
# Out-of-store symlinks (whole dir): edit live under ~/.zsh etc. with
# hot-reload where the app supports it, then `git diff` in this repo to
# decide what stays. Rollback for home files is git history, not HM
# generations (system rollback never touches these by design).
{ config, ... }:

let
  home = config.users.users.alexmatias.home;
  dotfiles = "${home}/.config/nix-config/modules/home/shell-files";
in
{
  home-manager.users.alexmatias = { config, ... }: {
    home.file.".zsh".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/zsh";
    home.file.".zshrc".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/zshrc";
    home.file.".tmux.conf".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/tmux.conf";
    home.file.".fzf.zsh".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/fzf.zsh";
    xdg.configFile."starship.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/starship.toml";
  };
}
