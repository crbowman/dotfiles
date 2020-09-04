# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_BIN_HOME=$HOME/.local/bin

# ZSH
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export ZSH=$ZDOTDIR/ohmyzsh
export ZSH_CACHE_DIR=$XDG_CACHE_HOME/zsh
export ZSH_COMPDUMP=$ZSH_CACHE_DIR/zcompdump-$SHORT_HOST-$ZSH_VERSION
export HISTFILE=$XDG_DATA_HOME/zsh/history
export DISABLE_AUTO_UPDATE=false
export ZSH_DISABLE_COMPFIX=true # don't warn about loading non-safe files
export ZSH_CUSTOM=$ZDOTDIR/custom
fpath=($ZSH_CUSTOM/functions $ZSH_CUSTOM/completions $fpath)


# LESS
export LESSHISTFILE=$XDG_CACHE_HOME/less/history
export LESSKEY=$XDG_CONFIG_HOME/less/lesskey

# PYENV
export PYENV_ROOT=$XDG_CONFIG_HOME/pyenv
export PATH=$PYENV_ROOT/bin:$PATH
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# MY ENV
export DOTFILES=$HOME/code/dotfiles

# PATH
path=($XDG_BIN_HOME
      $ZSH_CUSTOM/plugins/zsh-diff-so-fancy/bin
      /usr/local/{bin,sbin}
      $path)

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprofile"
fi
