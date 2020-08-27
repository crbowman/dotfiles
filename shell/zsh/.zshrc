export ZSH=$ZDOTDIR/.oh-my-zsh

ZSH_THEME="avit"

DOTFILES=$HOME/code/dotfiles

export ZSH_CUSTOM=$DOTFILES/shell/zsh/custom

fpath=($ZSH_CUSTOM/functions $ZSH_CUSTOM/completions $fpath)

plugins=(git
         lein
         extract
         colored-man-pages
         # Custom Plugins
         zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='emacs -nw'
else
  export EDITOR='emacs -nw'
fi

# Defines LS_COLORS
eval `dircolors $XDG_CONFIG_HOME/dir_colors/dircolors`
