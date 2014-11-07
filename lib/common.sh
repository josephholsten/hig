log() {
  echo "$@" >&2
}

debug() {
  if [ -n "$DEBUG" ]; then
    log "$@"
  fi
}

fatal() {
  log "$@"
  exit 1
}
