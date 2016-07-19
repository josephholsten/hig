SCCS command comparison

`hig ci [-m <msg>] [<file>...]`
:   commit changes to version history
sccs delta [-y <msg>] s.<file>
: make a delta to a file


`hig add <file>...`
:   add file to versioned files
sccs create <file>
:   Checks in the file for the first time, creating the revision history file


`hig co [<ref> [<file>...]]`
:   checkout files from a seperate branch
sccs get <file>
:   Check out a file for reading.
sccs get -e <file>
:    Check out a file for modification.
sccs get -r<ref> <file>
:   Check out file from revision ref

`hig diff [<ref> [<file>...]]`
:   show diff between current files and specified ref
sccs sccsdiff -rx -ry <file>
:   Compare two revisions.
sccs diffs <file>
:   Compare current with last revision.

`hig log  [<ref> [<file>...]]`
:   list revision history
sccs -R log
:   Print a Changelog for a project

`hig st`
:   show repo status
sccs prs <file>
:   Print a history of the file.
sccs tell
:   Print a list of edited files in "."
sccs -R tell
:   Print a list of edited files for a project
sccs info
sccs check

sccs branch
:   get -b -e; delta -s -n; get -e -t -g



`hig get <repo> [<directory>]`
:   get remote repo


`hig add <file>...`
:   add file to versioned files

`hig rm  <file>...`
:   remove file from version control, leaving the existing contents on
    disk


`hig pull [<repo>]`
:   pull changes from remote repository

`hig push [<repo>]`
:   push changes to remote repo

`hig lsbr`
:   list branches

`hig mkbr <branch>`
:   make new branch

`hig chbr <branch>`
:   change active branch

`hig rmbr <branch>`
:   remove branch

`hig lstag`
:   list tags

`hig mktag <tag> [<ref>]`
:   make new tag

`hig pick <ref>`
:   cherry pick a single patch

sccs edit <file>
:   sccs get -e <file>
sccs delget <file>
:   sccs delta <file>; sccs get <file>
sccs deledit <file>
:   sccs delta <file>; sccs get -e <file>
