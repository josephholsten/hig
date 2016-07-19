# hig - common ui to most revision control systems

I work on many open source projects, which often means I must deal with their version control system. But for some reason, when I'm switching between `git` and `hg`, I end up typing `hig`. Thus this tool. It also provides a bunch of shorthands because of laziness.

## Installation

    brew tap josephholsten/josephholsten
    brew install hig

## Opinions

* `ci` should commit all changes
* `rm` should not remove files from disk
* `diff` should use extended format

* require on modern versions of clients
* GPG support

## Commands

* `ci`
* `co`
* `get`
* `hig add`
* `hig diff`
* `hig log`
* `hig rm`
* `pull`
* `push`
* `st`

## Supports

- git http://www.git-scm.com/
- hg http://mercurial.selenic.com/
- svn https://subversion.apache.org/
- bzr http://bazaar.canonical.com/en/

## In Progress

* cvs http://www.nongnu.org/cvs/
cvs -d:pserver:anonymous@ex-vi.cvs.sourceforge.net:/cvsroot/ex-vi co ex-vi
get  pserver:anonymous@ex-vi.cvs.sourceforge.net:/cvsroot/ex-vi


## Does not support

- darcs http://darcs.net/
* rcs https://www.gnu.org/software/rcs/
* sccs http://sccs.sourceforge.net/
* camp http://projects.haskell.org/camp/
* fossil http://www.fossil-scm.org/
* p4 http://www.perforce.com/

## TODO:
investigate https://code.google.com/p/git-repo/
Launchpad + bzr workflow: http://stackoverflow.com/questions/20273368/launchpad-pull-request#20273376
