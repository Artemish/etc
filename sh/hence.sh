remindme() { 
  if [ $# -lt 2 ]; then
    echo "Usage: remindme <time difference> <command>" 2>&1
    return 1
  fi

  local t=${1}
  local command="/usr/bin/notify-send \"${2}\""
  local nice_date at_date
  nice_date=$(date -d "now + ${t}" +"%I:%M.%S%p")
  at_date=$(date -d "now + ${t}" +"%m%d%H%M.%S")
  echo "Scheduling '${command}' for ${nice_date}"

  at -f <(echo "${command}") -t "${at_date}" >/dev/null 2>&1
}
