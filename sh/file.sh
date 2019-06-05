#!/bin/bash

fext() {
  if [ -z "${2}" ]; then
    find . -type f -name "*.${1}" 
  else
    find . -type f -maxdepth "${2}" -name "*.${1}" 
  fi
}

fn() {
  if [ -z "${2}" ]; then
    find . -iname "*${1}*" 
  else
    find . -maxdepth "${2}" -iname "*${1}*" 
  fi
}

ff() {
  if [ -z "${2}" ]; then
    find . -type f -iname "*${1}*" 
  else
    find . -type f -maxdepth "${2}" -iname "*${1}*" 
  fi
}

fd() {
  if [ -z "${2}" ]; then
    find . -type d -iname "*${1}*" 
  else
    find . -type d -maxdepth "${2}" -iname "*${1}*" 
  fi
}

vf() {
    vim "$(ff "$@" | selecta)"
}

cfd() {
    cd "$(fd "$@" | selecta)"
}
