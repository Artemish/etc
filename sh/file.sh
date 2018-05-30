#!/bin/bash

fext() {
  if [ -z "${2}" ]; then
    find . -name "*.${1}" 
  else
    find . -maxdepth "${2}" -name "*.${1}" 
  fi
}

fn() {
  if [ -z "${2}" ]; then
    find . -iname "*${1}*" 
  else
    find . -maxdepth "${2}" -iname "*${1}*" 
  fi
}

vf() {
    vim "$(fn "$@" | selecta)"
}
