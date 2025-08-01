#!/bin/zsh
# copy from https://github.com/ryul99/.dotfiles/blob/da071a3186a4d4e3febe9bdd084705627f7f4060/home/.zshenv
# Cleanup some anaconda environment variables to avoid messing up in tmux, etc.
# (these environment variables might be copied and inherited unwantedly)
#unset CONDA_EXE
unset CONDA_PREFIX
unset CONDA_DEFAULT_ENV
unset CONDA_PYTHON_EXE
unset CONDA_SHLVL


if [ -e "$CONDA_EXE" ]; then
  path=( "${CONDA_EXE:A:h}" $path )
elif [ -d "$HOME/.miniconda3/bin/" ]; then
  path=( $path "$HOME/.miniconda3/bin" )
  export CONDA_EXE="$HOME/.miniconda3/bin/conda"
elif [ -d "/usr/local/miniconda3/" ]; then
  path=( $path "/usr/local/miniconda3/bin" )
  export CONDA_EXE="/usr/local/miniconda3/bin/conda"
elif [ -d "$HOME/miniconda3/bin/" ]; then
  path=( $path "$HOME/miniconda3/bin" )
  export CONDA_EXE="$HOME/miniconda3/bin/conda"
  
elif [ -d "$HOME/anaconda3/bin/" ]; then
  path=( $path "$HOME/anaconda3/bin" )
  export CONDA_EXE="$HOME/anaconda3/bin/conda"
  
elif [ -d "$HOME/.miniforge3/bin/" ]; then
  path=( $path "$HOME/.miniforge3/bin" )
  export CONDA_EXE="$HOME/.miniforge3/bin/conda"
elif [ -d "/usr/local/miniforge3/" ]; then
  path=( $path "/usr/local/miniforge3/bin" )
  export CONDA_EXE="/usr/local/miniforge3/bin/conda"
elif [ -d "$HOME/miniforge3/bin/" ]; then
  path=( $path "$HOME/miniforge3/bin" )
  export CONDA_EXE="$HOME/miniforge3/bin/conda"
fi

function _conda_initialize() {
  __conda_setup="$("${CONDA_EXE}" 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
    echo conda setup failed.. >&2
  fi
  unset __conda_setup
}
[[ -n "$CONDA_EXE" ]] && _conda_initialize
