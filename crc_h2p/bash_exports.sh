################################################################################
# This file contains all the bash exports and configurations that are specific
# to the CRC's H2p cluster
################################################################################

##### User specific environment and startup programs ###########################

  # Source global definitions. This allows access to the various python and perl
  # scripts written by the sys admins for making tasks easier
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

  # Set the prompt correctly.  This is required since $HOST just gives "loginX"
  # and I want host to be "h2p.loginX"
PS1='\[\e[0;33m\]\u\[\e[0m\]@\[\e[0;35m\]h2p.\h\[\e[0m\]:\[\e[0;34m\]\W\[\e[0m\]\]$ '

##### Load modules #############################################################
  # Make sure there are no unexpected modules loaded
module purge

  # Check if we're on a header node or a POWER9/V100 node
case "$DOTFILES_HOSTNAME" in
  h2p)
    # Load the standard modules for x86_64 nodes
    # General use modules
    module load gcc/8.2.0                   # Generally useful
    module load python/anaconda3.8-2020.11  # Python
    ;;

  h2p_ppc)
    # Load the POWER9/V100 modules
    # General use modules
    module load python/anaconda3-2020.11  # Python version I use.
    module load gcc/10.1.0                # Prereq for cuda/11.1.0
    module load cuda/11.1.0               # Required to compile Cholla

    # Personal environment modules
    module load nano/4.6                  # Modern version of nano

    # Cholla required modules
    module load openmpi/4.0.5             # MPI parallel compiler
    module load hdf5/1.12.0               # Required for Cholla datasets.
    module load googletest
    ;;

  *)
    RED='\033[0;31m'
    NC='\033[0m'  # No color
    echo -e "${RED}Hostname is not in list of H2P hostnames. No modules loaded${NC} "
    ;;
esac


##### Exports ##################################################################
export GPG_TTY=$(tty) #forces terminal usage instead of GUI among other things
