# hig - common ui to most revision control systems

I work on many open source projects, which often means I must deal with their version control system. But for some reason, when I'm switching between `git` and `hg`, I end up typing `hig`. Thus this tool. It also provides a bunch of shorthands because of laziness.

## Installation

osx

    brew tap josephholsten/josephholsten
    brew install hig

debian

    curl -s https://packagecloud.io/install/repositories/josephholsten/hig/script.deb.sh | sudo bash
    sudo apt install hig

## Opinions

* `ci` should commit all changes
* `rm` should not remove files from disk
* `diff` should use extended format

* require modern versions of clients
* GPG support

## Commands

* `hig get <repo> [<directory>]`: get remote repo

* `hig add <file>...`: add file to versioned files
* `hig rm  <file>...`: remove file from version control, leaving the existing contents on disk

* `hig ci [-m <msg>] [<file>...]`: commit changes to version history
* `hig co [<ref> [<file>...]]`: checkout files from a seperate branch

* `hig pull [<repo>]`: pull changes from remote repository
* `hig push [<repo>]`: push changes to remote repo

* `hig st`: show repo status
* `hig diff [<ref> [<file>...]]`: show diff between current files and specified ref
* `hig log [<ref> [<file>...]]`: list revision history

* `hig lsbr`: list branches
* `hig mkbr <branch>`: make new branch
* `hig chbr <branch>`: change active branch
* `hig rmbr <branch>`: remove branch

* `hig lstag`: list tags
* `hig mktag <tag> [<ref>]`: make new tag

* `hig format`: display local repo format
* `hig help`: display help

* `hig pick <ref>`: cherry pick a single patch
* `hig rebase [<ref>]`: apply local commits onto upstream ref

* `hig pr [<branch>]`: open a pull request on bitbucket or github
* `hig view [<file>]`: open file or repo website

## Completion

Best of all, we have bash tab completion for services. Place the
`completion/hig` script in `/etc/bash_completion.d` and you
should have completion the next time you log in. Or just `source` the
file to get it right now!

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
