# zinit — NixOS/Linux static render (chezmoi .tmpl resolved for linux).
# Source: chezmoi dot_zsh/10-zinit.zsh.tmpl. Re-render if that changes.
# shellcheck disable=SC1091
# Load from Nix store first, ~/.zinit fallback, auto-bootstrap last resort.
if [[ -f /nix/var/nixprofile/bin/zinit ]]; then
    source /nix/var/nixprofile/bin/zinit.zsh
elif [[ -f ~/.zinit/bin/zinit.zsh ]]; then
    source ~/.zinit/bin/zinit.zsh
else
    echo "Zinit not found. Installing..."
    mkdir -p ~/.zinit/bin
    git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
    source ~/.zinit/bin/zinit.zsh
fi

# Syntax highlighting — inmediato (debe ir antes de autosuggestions)
zinit light zsh-users/zsh-syntax-highlighting

# Autosuggestions — inmediato (evita conflicto con wrapper de Kiro CLI)
zinit light zsh-users/zsh-autosuggestions

# Git plugin de OMZ — lazy (aliases extra de git)
zinit ice wait lucid
zinit snippet OMZP::git

# Completions adicionales — lazy
zinit ice wait lucid
zinit light zsh-users/zsh-completions

# conda/mamba completions
zinit ice wait lucid
zinit light esc/conda-zsh-completion
