EDITOR=nvim

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
