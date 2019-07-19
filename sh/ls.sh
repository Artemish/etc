#!/usr/bin/env sh
l() {
  exa -lT --color=always "${@}" | less -FR
}
