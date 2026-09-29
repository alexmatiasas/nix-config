#-------------------------------------------------------------
# for all alias definitions
#-------------------------------------------------------------

# Alias útiles
alias cls='clear'
alias ll='ls -lah'
alias gs='git status'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias ss='exec zsh'
alias j='julia'
alias term_size='echo "Rows=$(tput lines) Cols=$(tput cols)"'
alias py='python3'
alias act='source .venv/bin/activate'
alias deact='deactivate'
alias alacritty='/Applications/Alacritty.app/Contents/MacOS/alacritty'
alias ls="eza --icons --group-directories-first --color=auto"
alias ll="eza -lah --icons --git --group-directories-first --color=auto"
alias tree="eza --tree --icons"
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias df='df -h'
alias du='du -h'
alias psa='ps aux --sort=-%cpu | head'
alias psmem='ps aux --sort=-%mem | head'
alias psg='ps aux | grep -i'
alias rm='rm -i'
alias cp='cp -iv'
alias mv='mv -iv'
alias grep='rg'
alias buu='brew update && brew upgrade --greedy'
alias gla='git log --oneline --decorate --graph --all'

# Alias normal para abrir VS Code en el directorio actual
alias code.='code .'

# Alias con profile (requiere que crees un perfil "cursor" en VS Code)
alias code-cursor='code --profile cursor'

# Alias con profile (requiere perfil "windsurf")
alias code-windsurf='code --profile windsurf'

