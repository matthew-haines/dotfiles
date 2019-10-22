# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="ys"

plugins=(
  git
  osx
)

source $ZSH/oh-my-zsh.sh

export PATH=/Library/TeX/texbin:/usr/local/bin:$HOME/iCloud/scripts:/usr/local/sbin:$PATH

# Prevent homebrew from updating repositories whenever it is run:
export HOMEBREW_NO_AUTO_UPDATE=1

# vim
bindkey -v
bindkey 'jj' vi-cmd-mode
bindkey "^?" backward-delete-char

# aliases
alias python="python3"
alias pip="pip3"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/matthew/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/matthew/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/matthew/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/matthew/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# syntax highlighting (goes last)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
