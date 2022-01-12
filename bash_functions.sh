################################################################################
# This file contains all the bash functions that are specific to $HOSTNAME
################################################################################
# ==============================================================================
set-tab () {
    #this function sets the iterm2 tab to be whatever you want. Defaults to
    #${HOSTNAME}

    #new we declare and assign an array with all paths to the repos in it
    if [[ ${1} ]] ; then
      title="${1}"
      export PROMPT_COMMAND='echo -ne "\033]0;${title}\007"'
    else
      export PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME}\007"'
    fi
}
# ==============================================================================


# ==============================================================================
remake () {
  # function for remaking

  # check for GNU time
  if hash gtime 2>/dev/null; then
        TIME="gtime"
  else
        TIME="/usr/bin/time"
  fi

  # set the format that GNU time prints out
  format="
Compile complete
Wall time   = %es
User time   = %Us
System time = %Ss
"
#Max Memory Usage = %MKB
  rm -iv compile.log

  echo -e "\nCleaning..."
  make clean

  echo -e "\nCompiling..."
  "${TIME}" -f "${format}" make -j > compile.log
  it2attention start
  it2attention fireworks
}
# ==============================================================================


# ==============================================================================
function replace_C() {
    # This function replaces C and c comment characters in Fortran with !

    # Usage
    # $1: the file(s) to do the find and replace in

    file=$1

    sed -i '' 's/^[cC]/!/' $file
}
# ==============================================================================


# ==============================================================================
function find-and-replace() {
    # This function finds strings and replaces them with other strings recursively

    # Usage
    # $1: the directory to do the find and replace in
    # $2: the string to find
    # $3: the string to replace with

    directory=$1
    find=$2
    replace=$3

    grep -rl "${find}" $directory | xargs sed -i '' -e "s/${find}/${replace}/g"
}
# ==============================================================================


# ==============================================================================
function iterm2_print_user_vars() {

  it2git

}
# ==============================================================================
