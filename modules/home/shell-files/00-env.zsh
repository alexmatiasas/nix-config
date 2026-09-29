# Static exports — no subprocesses, no evals
export LIBRARY_PATH=/usr/local/lib
export C_INCLUDE_PATH=/usr/local/include
export LD_LIBRARY_PATH=/usr/local/lib

export MAMBA_EXE="$HOME/miniforge3/bin/mamba"
export MAMBA_ROOT_PREFIX="$HOME/miniforge3"

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/llvm/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# juliaup — lazy, solo agrega al PATH cuando se llama julia/juliaup
julia() {
	export PATH="$HOME/.juliaup/bin:$PATH"
	unfunction julia juliaup
	julia "$@"
}

juliaup() {
	export PATH="$HOME/.juliaup/bin:$PATH"
	unfunction julia juliaup
	juliaup "$@"
}

