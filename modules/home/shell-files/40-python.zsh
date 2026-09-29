# uv — gestor principal de Python y versiones
export PATH="$HOME/.local/bin:$PATH"

# mamba — reemplaza conda completamente, usar siempre mamba en el día a día
# conda() se mantiene solo por compatibilidad con scripts que lo tengan hardcodeado
_load_mamba() {
	unfunction conda mamba 2>/dev/null
	if __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2>/dev/null)"; then
		eval "$__mamba_setup"
	else
		export PATH="$MAMBA_ROOT_PREFIX/bin:$PATH"
	fi
	unset __mamba_setup
}

conda() {
	_load_mamba
	conda "$@"
}
mamba() {
	_load_mamba
	mamba "$@"
}
