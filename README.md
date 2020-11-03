# Dotfiles
This is a central repo for my dotfiles. It's designed to work on macOS Mojave
and newer and on linux supercomputing clusters. It's a work in progress, use at
your own risk.


## Dependencies:
* bash >= 5.x
* nano >= 4.6
* git >= 2.24
* ack >= 3.x
* GNU coreutils >= 8.31
* GNU `time`

## Summary
1. `bash_profile.sh` just sources `~/.bashrc` which is symlinked to 'bashrc.sh'
2. `bashrc.sh` contains all the sourcing statements
3. `bash_aliases.sh` contains all the global aliases
4. `bash_exports.sh` contains all global variables and other export commands
5. `bash_functions.sh` contains all bash functions
6. `<repo-root>/bin` contains all global scripts
7. each host needs a directory with the hostname as the directory name and then
   must contain the local `bash_aliases.sh`, `bash_exports.sh`, and
   `bash_functions.sh` files and all the local scripts in
   `<repo-root>/HOSTNAME/bin`
  - For long or unwieldy hostnames a remapping can be done in `bashrc.sh`. See
    the example for the h2p cluster


## Setup Instructions
1. Fork this repo and change its name to "dotfiles"
2. Make sure there is nothing in the original dotfiles that you want to keep.
   They will be backed up to `~/.old-dotfiles-backup` but better safe than sorry
3. Check that ack, git, bash, and nano are all installed and of the appropriate
   version
   - If you are on macOS make sure to install GNU coreutils and GNU's
     implementation of `time` then run the following commands and make sure to
     them to your hosts `bashrc_exports.sh` file before running `setup.sh`
     - PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
     - MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
4. Clone this repo, it must be in the home directory. If you want to put it
   elsewhere you must change the setup script, the bashrc.sh file, and maybe
   others. I strongly recommend putting it on your home directory because every
   machine you use will have a home directory but might not have any additional
   directory structure.
5. Create a directory for the new machine that is named like
   `<repo-root>/HOSTNAME`. If the hostname is complex or there are multiple
   login nodes then you can remap them to a more human readable name in
   `bashrc.sh`; see the example there for the h2p cluster. You can find a
   working example for the H2P cluster at Pitt in the crc_h2p directory and you
   can make your own host directory by copying the host directory template in
   the `Templates` directory
6. Update `gitconfig` with your info and preferences. Any lines that have an
   equals sign with nothing on the right side of it either need to be edited
   with your information or deleted.
7. Run `setup.sh` in `<repo-root>/bin`. This will add soft links to
   `bash_profile.sh`, `bashrc.sh`, `nanorc`, `.pythonrc`, `.inputrc`, and
   `gitconfig` and will backup the old versions of those files to
   `~/.old-dotfiles-backup`
8. If you want to setup other dotfiles (`.vimrc` for example) then edit the list
   of linked dotfiles in `setup.sh` accordingly
9. (optional) Install iTerm2 Shell Integration by copying appropriate files
    from a machine that has up to date versions of them or by following iTerm2's
    installation instructions


## Setup instructions/notes for other things
1. Setting up git
   - When setting up ssh you have to use the `~/.ssh/config` file to tell ssh
     which key is for GitHub and which is for other things
2. Setting up GPG
   - If you want to set up commit signing see the instructions in
     `<repo-root>/How-To-Guides/GPG setup.md`


## Features
Here you will find a list of various aliases, functions, scripts, etc that are
in this repo along with brief usage instructions (more detailed documentation
can be found in the comments of a specific tool). Most of the tools are minimal
as this repo is intended to be skeleton for *your* dotfiles rather than a list
of *my* dotfiles.


### Miscellanous Features
- Always lists directory contents when you cd into a directory
- When starting a new shell it checks if your dotfiles are up to date. Note that
  this adds significantly to the startup time. See the section on the
  `Repo-check-updates.sh` script for details and how to disable it if you want
- Syntax coloring files for GNU Nano
- Bash should be case insensitive when autocompleting. This doesn't always work
- A `pythonrc.py` file that automatically imports a bunch of common libraries

### Bash Aliases
- `cp`, `mv`, `rm`, `ls`, `rsync`, `tree`, `du`, and `scp` all of these common
  commands have been aliased to include data protection, verbosity, or just to
  increase general usefulness
- `ldir` list all direcotries
- `la` shows hidden files as well
- `ack` aliases the `ack` tool to ignore some directories (.git etc), ignore case, and ignore regex
- `rmt` moves files to `~/.Trash`. A safer form of deleting
- `..` = `cd ../`
- `...` = `cd ../../`
- `.X` go back X directory levels where X = 3 to 6 inclusive
- `dotfiles` cd directly to your dotfiles directory
- `root` cd to the root of the current git repo
- `time` is dynamically aliased to the GNU implementation depending on OS
- `cppDebug`, `cppPerf`, `gfort_debug`, and `gfort_perf` various sets of
  compiler flags for C++ and Fortran to compile with debugging or performance
  oriented flags

### Bash Functions
- `message` send a SMS or iMessage when on macOS
- `remake` runs `make clean` then `make`. Pipes the result to `compile.log` and
  outputs how long the compile took using GNU Time
- `find-and-replace` finds one string in all the directory files and replaces it
  with another

### Bash Exports
- This is where you should be setting paths, environment variables, etc
- Sets the CLI prompt to be `user@host:PWD$ `


### Scripts
Note that scripts from any interpreted language (including python) can be run if
they are in the `<repo-root>/bin` or `<repo-root>/hostname/bin` directories.
Just make sure that the first line of the script is the appropriate shebang;
`#!/usr/bin/env bash` for bash and `#!/usr/bin/env python3` for python.
- `Repo-check-updates.sh` checks if the current github repos status compared to
  the upstream repo. It will tell you to pull or push or if the repo is up to
  date or has diverged. This script is mostly used indirectly through other
  scripts. It is run every time you start a new shell to check if the dotfiles
  repo is up to date. This add about 0.5 seconds to the startup time and can be
  disabled by commenting out the appropriate line in `bashrc.sh`
-`gitall.sh *command*` run the same git command on a bunch of repos. Running
  `gitall.sh check` will run `Repo-check-updates.sh` on every git repo. The list
  of repos used is given in the `gitall.sh` script
- `macos-update-script.sh` updates homebrew, homebrew packages, and your conda
  environment. Make sure to edit it to include which homebrew packages you want
  updated.
- `setup.sh` used for initial setup of this dotfiles system



### Git Config
- Make sure to set all the blank fields
- A git commit template is stored at `<repo-root>/git-message-template.txt`.
  Feel free to edit it to your own taste.
- Includes: this section is used for including GPG commit signing. See the
  instructions in `<repo-root>/How-To-Guides/GPG setup.md` for details

#### Git Aliases
- `stick` my preferred version of `git log`
- `stat` short for `status`
- `com` short for `commit`
- `check` runs `Repo-check-updates.sh` on the current git repo
- `new` shows all commits created by the last command
- `edit` opens all unstaged files for editing in VS Code. Easily edited to open
  unstaged files in any GUI editor that supports CLI invocation
- `hub` if you're on macOS it automatically opens the GitHub page for this repo.
  On other operating systems it prints out the URL for the GitHub page

### How To Guides
This directory contains some basic guides on setting up GPG signing of git
commits and bash performance profiling.

### Templates
A collection of templates for common tasks. Most have self explanatory names.

- `Host-directory-template` A template directory for a machines local dotfiles
- `git repo template` A template for git repos
- `Fortran module/program template.f90` Templates for Fortran code
- `python template.py` A template for python scripts
- `slurm-template.slurm` A template for a slurm submission script
- `PerfTimer.h` A C++ header only timing class for C++ code
