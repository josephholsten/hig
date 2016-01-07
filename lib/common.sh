log() {
  echo "$@" >&2
}

debug() {
  if [ -n "$DEBUG" ] || [ -n "$TRACE" ]; then
    log "$@"
  fi
}

trace() {
  if [ -n "$TRACE" ]; then
    log "$@"
  fi
}

fatal() {
  log "$@"
  exit 1
}

# sed with extended regular expressions
esed() {
    debug esed "$@"
    # check for BSD sed
    if (echo | sed -E >/dev/null 2>/dev/null); then
        sed -E "$@"
    # check for GNU sed
    elif (echo | sed -r >/dev/null 2>/dev/null); then
        sed -r "$@"
    else
        fatal "could not find BSD or GNU sed(1); it's needed for extended regular expressions"
    fi
}

# return the currently active branch in head
git_head() {
    git status -b --porcelain |
    head -n 1 |
    awk '{print $2}' |
    esed 's/\.\.\..*//'
}

# yes, I'm "parsing" uris with regexp. It's not quite as bad as parsing HTML though:
# http://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags/1732454#1732454


# extract path (excluding trailing ".git") from the repo url
#   git@gitlab:unicorn/rainbow.git                    => unicorn/rainbow
#   https://charlie@bitbucket.org/unicorn/rainbow.git => unicorn/rainbow
#   https://github.com/unicorn/rainbow.git            => unicorn/rainbow
#   https://github.com/unicorn/rainbow                => unicorn/rainbow
git_path_from_repo_url() {
    echo "$@" | esed 's/.*[:/]([^/]*\/[^\.]*)(\.git)?/\1/'
}

# extract owner or org (first path element) from the repo url
#   git@gitlab:unicorn/rainbow.git                    => unicorn
#   https://charlie@bitbucket.org/unicorn/rainbow.git => unicorn
#   https://github.com/unicorn/rainbow.git            => unicorn
git_owner_from_repo_url() {
    git_path_from_repo_url "$@" | esed 's/^([^/]*)\/[^/]*$/\1/'
}

# extract repo (final path element) from the repo url
#   git@gitlab:unicorn/rainbow.git                    => rainbow
#   https://charlie@bitbucket.org/unicorn/rainbow.git => rainbow
#   https://github.com/unicorn/rainbow.git            => rainbow
git_repo_from_repo_url() {
    git_path_from_repo_url "$@" | esed 's/^[^/]*\/([^/]*)$/\1/'
}

# extract host from the repo url
#   git@gitlab:unicorn/rainbow.git                    => gitlab.com
#   https://charlie@bitbucket.org/unicorn/rainbow.git => bitbucket.org
#   https://github.com/unicorn.git/rainbow.git        => github.com
git_host_from_repo_url() {
    echo "$@" | esed 's/^.*(@|:\/\/)([^:/]{1,})[:/].*$/\2/'
}
