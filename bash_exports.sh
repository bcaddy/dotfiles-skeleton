################################################################################
# This file contains all the bash exports and configurations that are for all
# hosts
################################################################################

##### System and bash Settings  ################################################
    # Set command prompt to be "user@host shell path$ "
export TERM="xterm-color"
PS1='\[\e[0;33m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]:\[\e[0;34m\]\W\[\e[0m\]\$ '

    # Source iTerm2 Shell integration files
source ~/.iterm2_shell_integration.bash

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
shopt -s checkwinsize


##### Exports ##################################################################
# Add <repo>/bin and <repo>/<host>/bin to the path such that the host bin
# is detected and used first, allowing scripts to be coppied and modified on
# a per host basis
export PATH="${repo_dir}/${host_dir}/bin:${repo_dir}/bin:${PATH}"

    # Export pythonrc file
export PYTHONSTARTUP="${HOME}/dotfiles/pythonrc.py"

##### Variables ################################################################
