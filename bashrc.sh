##### Check if dotfiles repo is up to date, run in background ##################
  # this is run first so that it can run in the background while everything else
  # is getting set up. 
echo -n "dotfiles repo: "
${HOME}/dotfiles/bin/Repo-check-updates.sh -p "${HOME}/dotfiles" &

# Root of the dotfile repository
repo_dir="$(dirname "$(realpath -P "${BASH_SOURCE[0]}")")"

# List of bash files to source, relative to the repository repo_directory
declare -a bash_sources
bash_sources=(
  bash_exports.sh
  bash_aliases.sh
  bash_functions.sh
)

# Hostname directory map
# This mapping is of the remote host's hostname to directory name
# NOTE: If a host's hostname is not found in this list, the script will look for
# a directory matching the host's name
declare -A host_dirs
    # Personal Machines
    
    # Remote Machines
host_dirs["login0.crc.pitt.edu"]="crc_h2p"
host_dirs["login1.crc.pitt.edu"]="crc_h2p"

# Source bash files at the root of the dotfile repository and from host
# repo_directories from the root of the dotfile repository (eg. ${repo}/host1/bashrc.sh)

host_dir="${HOSTNAME}"
if [[ "${!host_dirs[@]}" =~ $HOSTNAME ]] ; then
  host_dir="${host_dirs["$HOSTNAME"]}"
fi
for source_root in "$repo_dir" "$repo_dir/${host_dir}" ; do
  for bash_file in "${bash_sources[@]}" ; do
    source_file="${source_root}/${bash_file}"
    #echo "Checking ${source_file}" #mostly for debugging
    if [ -f "$source_file" ] ; then
      source "$source_file"
    else #mostly for debugging
      echo "WARNING: ${source_file} not found" #mostly for debugging
    fi
  done
done

##### Make sure all processes are finished #####################################
wait
