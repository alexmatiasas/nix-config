# Shell home files (Linux static renders of the chezmoi .tmpl sources).
# zinit keeps its auto-bootstrap: first login downloads plugins if absent.
{
  home-manager.users.alexmatias = {
    home.file.".zsh" = {
      source = ./shell-files/zsh;
      recursive = true;
    };
    home.file.".zshrc".source = ./shell-files/zshrc;
    home.file.".tmux.conf".source = ./shell-files/tmux.conf;
    home.file.".fzf.zsh".source = ./shell-files/fzf.zsh;
    xdg.configFile."starship.toml".source = ./shell-files/starship.toml;
  };
}
