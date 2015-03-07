# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias c='clear'
alias ..='cd ../'
alias ~="cd ~/"
alias ic='ping google.com'
alias x='exit'
alias lsd='ls -d */'
alias svnlog='svn log -v --limit 6 | less'
alias fnd='find ./ -name '

export HISTIGNORE=' *'

mr() { mpg123 --pitch $1 -Z ~/Music/weeaboo/*; }
mkcd() { mkdir "$1" && cd "$1"; }

db() {
  TEYJUS="/home/mitch/RenamingRedux";
  SOURCE="$TEYJUS/source";
  ocamldebug -I $SOURCE/compiler $SOURCE/front $SOURCE/linker $SOURCE/${1}.run $2;
}

FIGNORE='.o:.cmo:.cmx:.cmi'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

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

goto() {
  ALIAS_FILE=/home/mitch/git/goto/aliases.txt

  usage='Usage: goto [-m destination] name'

  if [[ $# == 0 ]] ; then
    echo "$usage"
    return 1
  fi

  # getopt seemed like overkill
  if [[ $1 == '-m' ]] ; then
    abspath=$(cd $(dirname $2); pwd)/$(basename $2)

    if ! [[ -e $abspath ]] ; then
      echo "No such directory: $abspath"
      return 2
    fi

    existing_re="^$abspath |$3$"
    _=`grep -E "$existing_re" $ALIAS_FILE`
    # If the alias is already there
    if [[ $? == 0 ]] ; then
      tmpfile=/tmp/goto.tmp
      touch $tmpfile
      grep -v -E "$existing_re" $ALIAS_FILE > tmpfile
      mv $tmpfile $ALIAS_FILE
    fi

    echo "$abspath $3" >> $ALIAS_FILE
  else
    re="$1$"
    newdir=`cat $ALIAS_FILE | grep -e $re | awk '{print $1}'`
    if [[ -e $newdir ]] ; then
      cd $newdir
      return 0
    else
      echo "No alias for '$1'."
      return -1
    fi
  fi
}

randwallpaper() {
  pushd /home/mitch/Pictures/Wallpapers > /dev/null
  entries=`ls | wc -l`
  n=$RANDOM
  let "n %= entries"
  let "n += 1"
  f=`ls | sed "${n}q;d"`
  abspath="$(pwd)/$f"
  gsettings set org.gnome.desktop.background picture-uri "file://${abspath}"
  popd > /dev/null
}

# Directory path shortener
export MYPS='$(echo -n "${PWD/$HOME/"~"}" |
awk -F "/" '"'"'{
if (length($0) > 30) {
  if (NF>4) print $1 "/" $2 "/.../" $(NF-1) "/" $NF;
  else if (NF>3) print $1 "/" $2 "/.../" $NF;
  else print $1 "/.../" $NF;
}
else print $0;}'"'"')'
PS1='$(eval "echo ${MYPS}")$ '
PS1="\[\e[0;31m\]\u:$PS1\[\e[m\]"

. ~/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

