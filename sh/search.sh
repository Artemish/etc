function short() {
  ag --color "${@}" | grep -Ev ".{120}"
}
