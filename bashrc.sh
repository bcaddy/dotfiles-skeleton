# Root of the dotfile repository
repo_dir="$(dirname "$(realpath -P "${BASH_SOURCE[0]}")")"

# List of bash files to source, relative to the repository repo_directory
declare -a bash_sources
bash_sources=(
  bash_exports.sh
  bash_aliases.sh
  bash_functions.sh
)

case $(hostname -f) in
  login?.crc.pitt.edu)
    host_dir="crc_h2p"
    export DOTFILES_HOSTNAME="h2p"
    ;;
  ppc-n?.crc.pitt.edu)
    host_dir="crc_h2p"
    export DOTFILES_HOSTNAME="h2p_ppc"
    ;;
  *)
    echo -n "Hostname not found in list of hosts for dotfiles"
esac


# Source bash files at the root of the dotfile repository and from host
# repo_directories from the root of the dotfile repository (eg. ${repo}/host1/bashrc.sh)
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

##### Check if dotfiles repo is up to date #####################################
if [[ $DOTFILES_HOSTNAME != "h2p_viz" ]]; then
  echo -n "dotfiles repo: "
  Repo-check-updates.sh -p "${HOME}/dotfiles"
fi
