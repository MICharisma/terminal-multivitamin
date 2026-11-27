#!/usr/bin/env zsh
# Permissions and ownership · 03 · Vienna music university, sharing chamber music scores
#
# Teaches:
#   - symbolic modes change only what they name: `o-rwx` leaves the owner and group bits alone
#   - capital `X` adds execute to folders (and to files already executable), so `g+rX`
#     opens folders without making PDFs executable; lowercase `x` would
#   - `g=u` copies the owner's bits to the group; `a-w` locks a folder for everyone, owner included
#   - comma lists apply several clauses in one call: `u=rwx,g=rx,o=`
set -o errexit -o nounset -o pipefail

if (( EUID == 0 )); then
  print -u2 "share_scores.zsh: run this as a regular user; root ignores read and write bits"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/mdw-kammermusik.XXXXXX")
trap 'chmod -R u+w -- "$workdir" 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

zmodload -F zsh/stat b:zstat
umask 077
mkdir -p kammermusik/{schubert-forellenquintett,brahms-klarinettenquintett}/final kammermusik/tools
for piece in kammermusik/*-*(/); do
  print "${piece:t}: Stimmen fuer Probe 3, Saal 2, Donnerstag 18:00" > $piece/parts.pdf
  print "${piece:t}: Fassung fuer das Konzert im Joseph Haydn-Saal" > $piece/final/parts.pdf
done
print '#!/bin/sh\necho "click track: 72 bpm, Andantino"' > kammermusik/tools/click_track.sh
chmod u+x kammermusik/tools/click_track.sh

typeset -A before
remember() {
  local entry
  before=()
  for entry in kammermusik/**/*(DN) kammermusik; before[$entry]=$(zstat -s +mode -- $entry)
}
changes() {
  local entry now
  print "== $1"
  for entry in ${(ok)before}; do
    now=$(zstat -s +mode -- $entry)
    [[ $now == $before[$entry] ]] || printf '  %-44s %s -> %s\n' ${entry#kammermusik/} $before[$entry] $now
  done
}

# region: capital-x
# focus: chmod -R g+rX kammermusik
remember
chmod -R g+rX kammermusik
changes "g+rX: the ensemble's group can open folders and read scores"
# endregion: capital-x

# region: lowercase-x
# focus: chmod -R g+rx kammermusik
cp -R kammermusik kammermusik-copy
chmod -R g+rx kammermusik-copy
print "== with lowercase x the PDFs become executable too:"
print "  $(zstat -s +mode -- kammermusik-copy/schubert-forellenquintett/parts.pdf) schubert-forellenquintett/parts.pdf"
rm -rf -- kammermusik-copy
# endregion: lowercase-x

# region: relative-change
# focus: chmod -R o-rwx kammermusik
chmod -R o+rX kammermusik/tools
remember
chmod -R o-rwx kammermusik
changes "o-rwx after a colleague's o+rX on tools: only the others bits move"
# endregion: relative-change

# region: copy-owner-bits
# focus: chmod g=u kammermusik/tools/click_track.sh
remember
chmod g=u kammermusik/tools/click_track.sh
changes "g=u: the group gets exactly the owner's bits"
# endregion: copy-owner-bits

# region: comma-clauses
# focus: chmod u=rwx,g=rx,o= kammermusik/tools/click_track.sh
remember
chmod u=rwx,g=rx,o= kammermusik/tools/click_track.sh
chmod -R a-w kammermusik/*/final
changes "u=rwx,g=rx,o= takes back g=u; a-w locks the concert versions"
if { print "late edit" >> kammermusik/schubert-forellenquintett/final/parts.pdf } 2>/dev/null; then
  print "  the final parts are still writable"
else
  print "  the final parts are locked, even for the teacher who owns them"
fi
# endregion: comma-clauses
