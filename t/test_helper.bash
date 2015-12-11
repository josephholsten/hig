mktmpdir() {
  mktemp -d ${TMPDIR:-/tmp}/${1:-tmp}.XXXXXXXXXX
}

flunk() {
  { if [ "$#" -eq 0 ]; then cat -
    else echo "$@"
    fi
  } | sed "s:${BATS_TEST_DIRNAME}:TEST_DIR:g" >&2
  return 1
}

assert_equal() {
  if [ "$2" != "$1" ]; then
    { echo "expected: \"$2\""
      echo "actual:   \"$1\""
    } | flunk
  fi
}

assert_match() {
  if ! expr "$1" : "$2" > /dev/null; then
    { echo "pattern: /$2/"
      echo "actual:  \"$1\""
    } | flunk
  fi
}

assert_file_exists() {
  if ! test -f "$1"; then
    { echo "file not found: \"$1\""
    } | flunk
  fi
}

# ex: sw=2 ft=sh
