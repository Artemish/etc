up() {
    #======================================================================
    # Taken from Reddit user sbicknel
    # modified to search by name
    # move up the directory tree
    # usage: up [N]
    #   N is an integer (defaults to 1)
    # 
    # silently exits if non-numeric input given
    # translates signed integers to absolute values
    # ignores all but the first parameter
    #
    # exit codes:
    #    0: success
    #    1: invalid input
    #    2: unable to change directory
    #    3: No matching directory found
    #  255: nothing to do
    #======================================================================

    declare targetDir="$PWD"        # new working directory starts from the current directory

    # convert parameter to an absolute value, if possible, or return error code
    number_re='^[0-9]+$'
    if [[ $1 =~ $number_re ]] ; then
      declare levels="${1:-1}"    # set the number of levels up the directory tree to traverse
      if [[ $levels =~ [^[:digit:]] ]]; then
          return 1
      fi


      # set targetDir to target directory
      for (( l=1; l<=levels; l++ )); do

          # %/* will produce an empty string in first-level directories.  This handles that case
          if [[ -n "${targetDir%/*}" ]]; then
              targetDir="${targetDir%/*}"
          else # set targetDir to / and break out of loop
              targetDir=/
              break
          fi
      done

      # if new working directory is different from current directory, change directories
    else
      directory_re=".*/[^/]*$1[^/]*$"
      while ! [[ $targetDir =~ $directory_re ]] ; do
        if [[ -n "${targetDir%/*}" ]]; then
          targetDir="${targetDir%/*}"
        else # Root reached without finding the directory
          pwd
          return 3
        fi
      done
    fi

    if [[ "$targetDir" != "$PWD" ]]; then
        cd "$targetDir" || return 2 # if cd fails
    else
        return -1 # nothing to do (exit code = 255)
    fi
}

