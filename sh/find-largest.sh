large_files () {
  if [ "${1}" ]; then
    find . -type f -print0 | xargs -0 ls -lSh | head -n "${1}"
  else
    find . -type f -print0 | xargs -0 ls -lSh | head 
  fi
} 

large_dirs () {
  if [ "${1}" ]; then
    find . -mindepth 1 -maxdepth 1 -type d -print0 | xargs -0 du -s | sort -rn | head -n "${1}"
  else
    find . -mindepth 1 -maxdepth 1 -type d -print0 | xargs -0 du -s | sort -rn | head 
  fi
} 
