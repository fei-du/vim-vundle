alias v='vim'
PATH=$PATH:~/bin
export PROJECT_PATHS=~/imx/fsl_release-bsp:~/profile/vim-vundle

export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-

# add bitbake to path
# PATH=/home/dufei/imx/poky/poky/bitbake/bin:$PATH
# PYTHONPATH=/home/dufei/imx/poky/poky/bitbake/lib

# bash-it enable plugin git
# bash-it enable plugin tmux
# bash-it enable alias git
# bash-it enable alias tmux

# ctrl + x + e edit command line in editor
export EDITOR=vim
# edit previous command in editor, save and run
# fc
alias path='echo -e ${PATH//:/\\n}'
alias ls='ls -h --color'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.
# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe() { find . -type f -iname '*'"${1:-}"'*' \
-exec ${2:-file} {} \;  ; }
