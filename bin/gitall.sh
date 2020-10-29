#!/usr/bin/env bash

# This script runs the same git command on many different repos.
# Primarily this is supposed to be used for pushing or pulling all the repos
# at once but could also be used for git status or any other command.


#this is the git command that will be executed, push, pull, status, etc
git_command=${1}

#new we declare and assign an array with all paths to the repos in it
if [[ "${HOSTNAME}" = "HOSTNAME 1" ]] ; then
  repo_path=(
      ''
      ''
  )
elif [[ "${HOSTNAME}" = "HOSTNAME 2" || "${HOSTNAME}" = "HOSTNAME 3" ]] ; then
  repo_path=(
      ''
      ''
  )
else
  echo "Host not found. Exiting"
  break
fi

#define some colors so that I can have some echo's show color
NC='\033[0m' # No Color
HIGHLIGHT_COLOR='\033[0;33m'

# now loop over all the elements in the repo_path array and run the same git command with them
if [ "${git_command,,}" == "check" ]; then
    for path in "${repo_path[@]}"
    do
        echo -e "${HIGHLIGHT_COLOR} $path ${NC}"
        Repo-check-updates.sh -p "${path}"
        echo
    done
else
    for path in "${repo_path[@]}"
    do
        echo
        echo -e "${HIGHLIGHT_COLOR} $path ${NC}"
        git -C $path $git_command
        echo
    done
fi
