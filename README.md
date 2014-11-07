# hig - common ui to most revision control systems

I work on many open source projects, which often means I must deal with their version control system. But for some reason, when I'm switching between `git` and `hg`, I end up typing `hig`. Thus this tool. It also provides a bunch of shorthands because of laziness.


## Opinions

`ci` should commit all changes
`rm` should not remove files from disk
`diff` should use extended format

Depends on modern versions of clients
GPG support

## Supports

- git http://www.git-scm.com/
- hg http://mercurial.selenic.com/
- svn https://subversion.apache.org/
- bzr http://bazaar.canonical.com/en/

## Does not support

- darcs http://darcs.net/
* cvs http://www.nongnu.org/cvs/
* rcs https://www.gnu.org/software/rcs/
* sccs http://sccs.sourceforge.net/
* camp http://projects.haskell.org/camp/
* fossil http://www.fossil-scm.org/
* p4 http://www.perforce.com/
