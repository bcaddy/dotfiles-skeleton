################################################################################
# This file contains all the bash aliases that are for all hosts
################################################################################

##### Aliases ##################################################################
  # Alias to resource bash_profile and bashrc
alias reload='source ~/.bash_profile'

  # Aliases for common terminal commands
alias cp='cp -iv'                        # ask before overwriting and be verbose
alias mv='mv -iv'                        # ask before overwriting and be verbose
alias rm='rm -iv'                        # ask before removing and be verbose
alias ls='ls --color=auto'               # make ls colorful
alias ldir='ls -d */ --color=auto'       # list all directories only
alias la='ls -A --color=auto'            # -a shows hidden files and directories
alias scp='echo "You should use rsync"'  # 'nuf said
alias grep='grep --color=auto'           # add colors to grep
alias ack='ack --ignore-dir={_site,.git,.container,._site} --ignore-case --literal'  # Ignore some directories, make searches case-insensitive, ignore regex
alias rsync='rsync -ah --info=progress2' # copy files with a progress bar
alias rmt='mv --force -t ~/.Trash '      # move a file to the trash instead of rming it
alias tree='tree -C'                     # show tree colorized
alias du='du -hs'                        # show file/dir size, human readable, top level only

  # Various cd aliases
cd() { builtin cd "$@"; ls; }    # Always list directory contents upon 'cd'
alias cd..='cd ../'              # Go back 1 directory level (for fast typers)
alias ..='cd ../'                # Go back 1 directory level
alias ...='cd ../../'            # Go back 2 directory levels
alias .3='cd ../../../'          # Go back 3 directory levels
alias .4='cd ../../../../'       # Go back 4 directory levels
alias .5='cd ../../../../../'    # Go back 5 directory levels
alias .6='cd ../../../../../../' # Go back 6 directory levels

  # CD directly to certain directories
alias dotfiles='cd ~/dotfiles'
alias root='cd $(git rev-parse --show-toplevel)'

  # C++ Compile Aliases
alias cppDebug="g++ -std=c++17 -Wall -Wextra -Wpedantic -g"
alias cppPerf="g++ -std=c++17 -O3 "

  # gfortran Compile Aliases
alias gfort_debug='gfortran -std=f2018 -Wextra -Wall -pedantic -fimplicit-none -fcheck=all -Og -g -fbacktrace '
alias gfort_perf='gfortran -std=f2018 -fimplicit-none -O3 '
alias caf_debug='caf -std=f2018 -Wextra -Wall -pedantic -fimplicit-none -fcheck=all -Og -g -fbacktrace '
alias caf_perf='caf -std=f2018 -fimplicit-none -O3 '

  # Alias GNU time correctly
if hash gtime 2>/dev/null; then
  alias time="gtime"
else
  alias time="/usr/bin/time"
fi
