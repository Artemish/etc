# With 'kill': generally, send 15, and wait a second or two, and if that doesn't work, send
# 2, and if that doesn't work, send 1. If that doesn't, REMOVE THE BINARY
# because the program is badly behaved!

pidrunning() {
  if [ $# -lt 1 ]; then
    echo "Usage: pidrunning pid"
    return 1
  fi

  ps -p "$1" > /dev/null 2>&1

  return $?
}

nkill() {
  if [ $# -lt 1 ]; then
    echo "Usage: nkill pid/name"
    return 1
  fi

  local PID

  if [[ "$1" =~ ^[0-9]+$ ]]; then
    PID="$1"
  else
    local res="$(pgrep "$1" | awk '{ print $2 }')"
    if [ -n "$res" ]; then
      PID="$res"
    else
      echo "Couldn't find process '$1'."
      return 2
    fi
  fi

  if ! pidrunning "$PID"; then 
    return 0
  fi

  kill -15 "$PID"
  # Wait 2 seconds
  for _ in [ 1 .. 8 ]; do
    sleep 0.25
    if ! pidrunning "$PID"; then 
      return 0
    fi
  done


  kill -2 "$PID"
  # Wait 1 second
  for _ in [ 1 .. 4 ]; do
    sleep 0.25
    if ! pidrunning "$PID"; then 
      return 0
    fi
  done

  kill -1 "$PID"

  if pidrunning "$PID"; then 
    echo "Couldn't kill process ${PID}. :/"
    return 1
  else
    return 0
  fi
}
