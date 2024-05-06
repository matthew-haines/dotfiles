# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export TOOLBIN=$HOME/Documents/cs452/toolchain/bin

ZSH_THEME="matthew"

source $ZSH/oh-my-zsh.sh

path+=$HOME/.cargo/bin
path+=/Library/TeX/texbin
path+=/usr/local/sbin
path+=$HOME/sources/wabt/bin

export NVM_DIR="$HOME/.nvm"
export HOMEBREW_PREFIX="$(brew --prefix)"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" --no-use

export PATH

# Prevent homebrew from updating repositories whenever it is run:

# vim mode
bindkey -v
# bindkey 'jj' vi-cmd-mode
bindkey "^?" backward-delete-char

export EDITOR=nvim
export CC=cc
export CXX=c++

# cmake
export CMAKE_GENERATOR=Ninja

# aliases
alias python="python3.10"
alias pip="pip3.10"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias clang15="$(brew --prefix llvm)/bin/clang"
alias clang++15="$(brew --prefix llvm)/bin/clang++"

alias c++20="clang++15 -std=c++20"

alias g++14="/usr/local/Cellar/gcc/bin/g++-11 -std=c++14 -Wall"

# lightweight vi and full vim
alias vi="nvim --cmd \"let g:cocdisabled = v:true\""
alias vim="nvim"

# syntax highlighting (goes last)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias cs-tmux="ssh cs-server -t 'tmux -CC attach || tmux -CC'"
