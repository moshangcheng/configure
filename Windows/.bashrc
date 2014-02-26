(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed
# http://stackoverflow.com/questions/11616835/cygwin-r-command-not-found-bashrc-bash-profile

export CC=gcc
export CXX=g++
source ~/.git-completion.bash

# set Visual Studio Env on Windows

# source ~/enter_vs.sh
alias vs=MSBuild.exe
