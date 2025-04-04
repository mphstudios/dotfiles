#!/bin/zsh
# Copyright 2013 Mark Lodato <lodato@google.com>
# Released under the MIT license; see LICENSE for details.

SUBDIRECTORY_OK=Yes
OPTIONS_KEEPDASHDASH=
OPTIONS_SPEC="\
git zmv [options] <srcpat> <dest>

Use zsh's \"zmv\" module with \"git mv\".  If invoked as 'mmv', -wW is assumed.
--
dry-run         dry run (passed to git-mv)
f,force         force move/rename even if target exists
i,interactive   show each line to be executed and ask whether to execute it
k               skip move/rename errors
n               print git-mv commands but do not execute
v,verbose       be verbose; given twice, be extra verbose
w               implicitly add parentheses to wildcards in <srcpat>
W               implicitly turn wildcards in <dest> into \${1} .. \${N}
"

autoload zmv
emulate sh

. "$(git --exec-path)/git-sh-setup"
require_work_tree

dest_wild=
force=
git_dry_run=
git_verbose=
interactive=
skip=
src_wild=
zmv_dry_run=
zmv_verbose=

case "$0" in
  *-mmv)
    src_wild=-w
    dest_wild=-W
    ;;
esac

while test $# != 0
do
  case "$1" in
  --dry-run)
    git_dry_run=-n ;;
  -f|--force)
    force=-f ;;
  -i|--interactive)
    interactive=-i ;;
  -k)
    skip=-k ;;
  -n)
    zmv_dry_run=-n ;;
  -v|--verbose)
    if [[ -n $zmv_verbose ]]; then
      zmv_verbose=-v
    else
      git_verbose=-v
    fi
    ;;
  -w)
    src_wild=-w ;;
  -W)
    dest_wild=-W ;;
  --)
    shift; break ;;
  *)
    break ;;
  esac
  shift
done

if [[ $# -ne 2 ]]; then
  usage
fi

emulate zsh
zmv -p git -o "mv $force $skip $git_dry_run $git_verbose" \
  $interactive $zmv_dry_run $zmv_verbose $src_wild $dest_wild -- "$@"
