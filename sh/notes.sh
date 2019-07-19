EDITOR=nvim

_note_files() { 
  FILES=($(find ~/notes -name '*.txt' | xargs -L 1 basename | sed 's/.txt//'))
  COMPREPLY=($(compgen -W "${FILES[*]}" "${COMP_WORDS[1]}"))
}

notes() { 
  local DATE
  DATE=$(date +'%A_%F')
  local FILE
  if [ $# -gt 0 ]; then
    FILE="${HOME}/notes/${1}.txt"
  else
    FILE="${HOME}/notes/${DATE}.txt"
  fi
  ${EDITOR} + "${FILE}"
}

complete -F _note_files notes

log_entry() {
  local DATE
  local TIME
  local FILE

  DATE=$(date +'%A_%F')
  TIME=$(date +'%I:%M %p')
  FILE="${HOME}/notes/${DATE}.txt"

  if [ $# -gt 0 ]; then
    printf '[%s]: %s\n' "${TIME}" "$*" >> "${FILE}"
  else
    printf '[%s]: ' "${TIME}" >> "${FILE}"
    ${EDITOR} + "${FILE}"
  fi
}
