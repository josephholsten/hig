#!/usr/bin/env bats

load test_helper

setup() {
  # HIGPATH="$(realpath "$BATS_TEST_DIRNAME/../bin")"
  HIGPATH="$BATS_TEST_DIRNAME/../bin"
  PATH="$HIGPATH:$PATH"
  WORKING="$(mktmpdir)"
  cd "$WORKING"
  git init > /dev/null
}

teardown() {
  rm -rf "$WORKING"
}

@test "get git:" {
  skip;
  REPO=git://git.kernel.org/pub/scm/git/git.git
}

@test "get https:" {
  skip;
  REPO=https://github.com/git/git
}

@test "get ssh:" {
  skip;
}

# git: repo

# git https: repo

@test "add" {
  echo foo > foo

  hig add foo

  run hig st
  assert_equal "${lines[0]}" "On branch master"
  assert_equal "${lines[1]}" "Initial commit"
  assert_equal "${lines[2]}" "Changes to be committed:"
  assert_equal "${lines[3]}" '  (use "git rm --cached <file>..." to unstage)'
  assert_equal "${lines[4]}" "	new file:   foo"
}

@test "rm" {
  echo foo > foo
  hig add foo
  hig ci -m 'initial' > /dev/null

  run hig rm foo

  assert_equal "${lines[0]}" "rm 'foo'"
  assert_file_exists foo # should not delete file
  run hig st
  assert_equal "${lines[0]}" "On branch master"
  assert_equal "${lines[1]}" "Changes to be committed:"
  assert_equal "${lines[2]}" '  (use "git reset HEAD <file>..." to unstage)'
  assert_equal "${lines[3]}" "	deleted:    foo"
}

@test "ci" {
  echo foo > foo
  hig add foo

  run hig ci -m 'initial'

  assert_match "${lines[0]}" "\[master (root-commit) .......\] initial"
  assert_equal "${lines[1]}" " 1 file changed, 1 insertion(+)"
  assert_equal "${lines[2]}" " create mode 100644 foo"
}

@test "co" {
  echo foo > foo
  hig add foo
  hig ci -m 'initial' > /dev/null
  hig mkbr bar
  echo bar > foo
  hig ci -m 'foo: bar' > /dev/null

  hig co master foo

  run hig diff head
  assert_equal "${lines[0]}" "diff --git a/foo b/foo"
  assert_match "${lines[1]}" "index ................ 100644"
  assert_equal "${lines[2]}" "--- a/foo"
  assert_equal "${lines[3]}" "+++ b/foo"
  assert_equal "${lines[4]}" "@@ -1 +1 @@"
  assert_equal "${lines[5]}" "-bar"
  assert_equal "${lines[6]}" "+foo"
}

@test "pull" { skip; }
@test "push" { skip; }

@test "st" {
  run hig st

  assert_equal "${lines[0]}"  "On branch master"
  assert_equal "${lines[1]}"  "Initial commit"
  assert_equal "${lines[2]}"  'nothing to commit (create/copy files and use "git add" to track)'
}

@test "diff" {
  echo foo > foo
  hig add foo
  hig ci -m 'initial' > /dev/null
  echo bar > foo

  run hig diff

  assert_equal "${lines[0]}" "diff --git a/foo b/foo"
  assert_match "${lines[1]}" "index ................ 100644"
  assert_equal "${lines[2]}" "--- a/foo"
  assert_equal "${lines[3]}" "+++ b/foo"
  assert_equal "${lines[4]}" "@@ -1 +1 @@"
  assert_equal "${lines[5]}" "-foo"
  assert_equal "${lines[6]}" "+bar"
}

@test "log" {
  echo foo > foo
  hig add foo
  hig ci -m 'initial' > /dev/null

  run hig log

  assert_match "${lines[0]}" "commit ........................................"
  assert_match "${lines[1]}" "Author: "
  assert_match "${lines[2]}" "Date: "
  assert_equal "${lines[3]}" "    initial"
}

@test "lsbr" {
  echo foo > foo
  hig add foo
  hig ci -m 'initial' > /dev/null

  run hig lsbr

  assert_equal "${lines[0]}" "* master"
}

@test "mkbr" {
  echo foo > foo
  hig add foo
  hig ci -m 'initial' > /dev/null

  hig mkbr feature-unicorn

  run hig lsbr
  assert_equal "${lines[0]}" "* feature-unicorn"
  assert_equal "${lines[1]}" "  master"
}

@test "chbr" {
  echo foo > foo
  hig add foo
  hig ci -m 'initial' > /dev/null
  hig mkbr feature-unicorn

  hig chbr master

  run hig lsbr
  assert_equal "${lines[0]}" "  feature-unicorn"
  assert_equal "${lines[1]}" "* master"
}

@test "rmbr" {
  echo foo > foo
  hig add foo
  hig ci -m 'initial' > /dev/null
  hig mkbr feature-unicorn

  hig rmbr master

  run hig lsbr
  assert_equal "${lines[0]}" "* feature-unicorn"
}

@test "mktag" {
  echo foo > foo
  hig add foo
  hig ci -m 'initial' > /dev/null

  hig mktag 0.1.0

  run hig lstag
  assert_equal "${lines[0]}" "0.1.0"
}

@test "pick" { skip; }
@test "rebase" { skip; }

@test "pr" { skip; }
@test "view" { skip; }

# ex: sw=2 ft=sh
