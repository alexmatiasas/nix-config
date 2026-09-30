#-------------------------------------------------------------
# for custom shell functions
#-------------------------------------------------------------

# cat improved
cat() {
	if [ -t 1 ]; then
		command cat "$@" | less
	else
		command cat "$@"
	fi
}

# mkcd create dir and then enter there
mkcd() { mkdir -p "$1" && cd "$1" || exit; }

# asking to retry previous command with sudo privileges
pls() {
	sudo "$(history -p !!)"
}

# extract files

extract() {
	if [ -f "$1" ]; then
		case "$1" in
		*.tar.bz2) tar xjf "$1" ;;
		*.tar.gz) tar xzf "$1" ;;
		*.bz2) bunzip2 "$1" ;;
		*.rar) unrar x "$1" ;;
		*.gz) gunzip "$1" ;;
		*.tar) tar xf "$1" ;;
		*.tbz2) tar xjf "$1" ;;
		*.tgz) tar xzf "$1" ;;
		*.zip) unzip "$1" ;;
		*.7z) 7z x "$1" ;;
		*) echo "no puedo extraer '$1'" ;;
		esac
	else
		echo "'$1' no es un archivo válido"
	fi
}

# abre Cursor en el directorio actual (o recibe archivos/rutas)
cursor() {
	# -n abre una nueva instancia si ya hay una abierta
	# --args pasa los argumentos directamente a la app
	open -n -a "Cursor" --args "$@"
}

# abre Windsurf en el directorio actual (o recibe archivos/rutas)
windsurf() {
	open -n -a "Windsurf" --args "$@"
}

function y() {
	local tmp
	tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	local cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || exit
	rm -f -- "$tmp"
}
