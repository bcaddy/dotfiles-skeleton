#!/usr/bin/env bash

# This script automates all the updates for my various command line tools, conda installation, etc
#To Update Anaconda and all Packages

confirm_func () {
    #this function runs the update commands.  When using this function simply
    #have your update message as the first thing following it then the command
    #you want to run
    while true; do
        echo ''
        read -p "${1}" yn
        case ${yn} in
            [Yy]* ) echo ${2}; ${2}; break;;
            [Nn]* ) break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}


confirm_func 'Update Homebrew itself? (y/n): '\
             'brew update'

confirm_func 'Check what Homebrew packages are outdated? (y/n): '\
             'brew outdated'

declare -a packages
packages=(
   'ack'
   'bash'
   'coreutils'
   'doxygen'
   'gcc'
   'git'
   'gnupg'
   'gnu-time'
   'graphviz'
   'grep'
   'hunspell'
   'make'
   'nano'
   'rsync'
   'sl'
   'tree'
)

prompt="Upgrade the following Homebrew packages? ${packages[@]} (y/n): "
command="brew upgrade ${packages[@]}"
confirm_func "${prompt}"\
             "${command}"

confirm_func 'Clean up old Homebrew packages? (y/n): '\
             'brew cleanup'

# confirm_func 'Update the Fortran Language Server? (y/n): '\
#              'pip install fortran-language-server -U'

confirm_func 'Update all Anaconda packages? (y/n): '\
             'conda update --all'
