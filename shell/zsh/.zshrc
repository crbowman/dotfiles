
ZSH_THEME="avit"

plugins=(git
         lein
         extract
         colored-man-pages
         # Custom Plugins
         zsh-diff-so-fancy
         zsh-syntax-highlighting) # Must be last plugin loaded


source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='emacs -nw'
else
  export EDITOR='emacs -nw'
fi

# Defines LS_COLORS
eval `dircolors $XDG_CONFIG_HOME/dircolors/dircolors-solarized/dircolors.256dark`
