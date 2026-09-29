# docker completions — estáticas vía fpath
# shellcheck disable=SC2206
[[ ! " ${fpath[*]} " =~ $HOME/.docker/completions ]] && fpath=(~/.docker/completions $fpath)
