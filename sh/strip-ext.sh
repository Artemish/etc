strip_ext() {
  if [ $# -lt 1 ]; then
    echo "Usage: strip_ext <filename>"
  fi

  echo $(basename "${1%.*}")
}
