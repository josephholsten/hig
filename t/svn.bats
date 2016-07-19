# svn repo
REPO=https://svn.apache.org/repos/asf/subversion/trunk


  HIGPATH="$(realpath "$BATS_TEST_DIRNAME/../bin")"
  PATH="$HIGPATH:$PATH"
  WORKING="$(mktmpdir)"
  cd "$WORKING"
  svnadmin create .
