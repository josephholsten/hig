hig(1) -- common access to revision control
===========================================

## DESCRIPTION


Unified access for version control systems including bzr(1), cvs(1), darcs(1), git(1), hg(1), svn(1).

## SYNOPSIS

`hg command [option...] [argument...]`

Wraps the most common commands you will use in multiple systems. Supported commands are:

* `hig get <repo> [<directory>]`: get remote repo

* `hig add <file>...`: add file to versioned files
* `hig rm  <file>...`: remove file from version control, leaving the existing contents on disk

* `hig ci [-m <msg>] [<file>...]`: commit changes to version history
* `hig co [<ref> [<file>...]]`: checkout files from a seperate branch

* `hig pull [<repo>]`: pull changes from remote repository
* `hig push [<repo>]`: push changes to remote repo

* `hig st`: show repo status
* `hig diff [<ref> [<file>...]]`: show diff between current files and specified ref
* `hig log  [<ref> [<file>...]]`: list revision history

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

## OPTIONS

## EXAMPLES

## SEE ALSO

bzr(1),
cvs(1),
darcs(1),
git(1),
hg(1),
svn(1)
