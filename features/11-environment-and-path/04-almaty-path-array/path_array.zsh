#!/usr/bin/env zsh
# Environment and PATH · 04 · Almaty mountain weather desk, editing PATH as a zsh array
#
# Teaches:
#   - in zsh, `$path` is an array tied to `$PATH`: change one and the other follows
#   - `path=( ~/bin $path )` prepends; `path+=( /opt/tools/bin )` appends
#   - `${(F)path}` prints one entry per line; `${#path}` is the count
#   - `typeset -U path` keeps the array unique so a directory is not searched twice
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/kazhydromet.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"
mkdir -p bin forecast/bin /tmp/dummy-ignore 2>/dev/null || true
mkdir -p bin forecast/bin

# region: tied
# focus: path=( $workdir/bin /usr/bin /bin )
path=( $workdir/bin /usr/bin /bin )
print "== PATH after setting path array:"
print "  $(print -r -- $PATH | sed "s|$workdir|WORK|g")"
# endregion: tied

# region: prepend-append
# focus: path=( $workdir/forecast/bin $path )
path=( $workdir/forecast/bin $path )
path+=( $workdir/bin )
print "== after prepend forecast/bin and append bin again:"
print -l -- $path | sed "s|$workdir|WORK|; s/^/  /"
# endregion: prepend-append

# region: unique
# focus: typeset -U path
print "== entries before unique: $#path"
typeset -U path
print "== after typeset -U path: $#path"
print -l -- $path | sed "s|$workdir|WORK|; s/^/  /"
# endregion: unique

# region: join
# focus: ${(F)path}
print "== one per line with join flag (F):"
print -r -- ${(F)path} | sed "s|$workdir|WORK|; s/^/  /"
# endregion: join
