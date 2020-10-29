################################################################################
# This file contains all the bash aliases that are specific to the CRC's H2p
# cluster
################################################################################

##### Aliases ##################################################################
  # Misc. Aliases
alias myq='crc-squeue.py --start'
alias clean-cholla='rm *.h5 *.png *.err *.out'
alias wrappers='imgcat ${HOME}/dotfiles/crc_h2p/bin/wrappers.png'
alias gdb="${HOME}/dotfiles/crc_h2p/bin/gdb-run.sh"

  # Start interactive jobs
alias gputest="(set -x; crc-interactive.py --gpu --partition=gtx1080 --time=1 --num-gpus=1)"
alias cputest="(set -x; crc-interactive.py --smp --time=1 --num-cores=1)"

  # CD directly to certain directories

  # Aliases for python programs
