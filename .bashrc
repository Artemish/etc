export HISTIGNORE=' *'

# Ignore compiled ocaml files in bash completion
FIGNORE='.o:.cmo:.cmx:.cmi'

# Directory path shortener
export MYPS='$(echo -n "${PWD/$HOME/"~"}" |
awk -F "/" '"'"'{
if (length($0) > 30) {
  if (NF>4) print $1 "/" $2 "/.../" $(NF-1) "/" $NF;
  else if (NF>3) print $1 "/" $2 "/.../" $NF;
  else print $1 "/.../" $NF;
}
else print $0;}'"'"')'
PS1='$(eval "echo ${MYPS}")'

RED="\[\e[0;31m\]"
GREEN="\[\e[0;32m\]"
YELLOW="\[\e[1;33m\]"
BLUE="\[\e[0;36m\]"
UNCOLOR="\[\e[m\]"

# Hash the hostname into a unique prompt color
{ 
  local HOSTHASH, COLORCODE
  HOSTHASH="$(printf "%d" 0x$(echo $HOSTNAME | md5sum))"
  COLORCODE=$(echo "(${HOSTHASH} % 6) + 31" | bc)
  HOSTCOLOR="\[\e[0;${COLORCODE}m\]"
} 2> /dev/null || HOSTCOLOR=$YELLOW

# Color my name red if I'm root, can't be too careful
if [ "$(whoami)" == "root" ]; then
  UCOLOR=${RED}
else
  UCOLOR=${BLUE}
fi

PS1="${UCOLOR}\u@${HOSTCOLOR}\h ${GREEN}$PS1 ${RED}\$${UNCOLOR} "

set -o vi

if [ -d ~/.bash ]; then
  for addon in ~/.bash/*.sh; do
    source "${addon}";
  done
fi
