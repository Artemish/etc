# Outputs the ip address of a given domain name
toip() {
  if [[ "$#" -ne 1 ]]; then
    >&2 echo "Usage: toip name"
    return 1
  fi

  # Only output the first result
  RES="$(dig +short $1 | head -n 1)"
  if [ "${RES}" ]; then
    echo "${RES}"
  else
    # Print to stderr
    >&2 echo "Hostname $1 not found"
  fi
}

# Outputs the network address of the given interface
localip() {
  if [[ "$#" -ne 1 ]]; then
    >&2 echo "Usage: localip interface"
  fi

  RES=$(ifconfig "$1")
  if [ "$RES" ]; then
    ADDR="$(echo "${RES}" | perl -n -e'/inet addr:(\S+)/ && print $1')"
    if [ "${ADDR}" ]; then
      echo "${ADDR}";
    else
      >&2 echo "Interface '$1' has no network address."
    fi
  else
    >&2 echo "Interface '$1' not found."
  fi
}
