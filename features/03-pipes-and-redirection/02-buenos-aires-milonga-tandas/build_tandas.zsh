#!/usr/bin/env zsh
# Pipes and redirection · 02 · Buenos Aires milonga DJ, building tandas
#
# Teaches:
#   - every command has two output streams: stdout (1) for results, stderr (2) for complaints
#   - `> list 2> warnings` sends each stream to its own file; `2>/dev/null` drops the complaints
#   - `> file 2>&1` puts both streams in the file; `2>&1 > file` does not, because
#     redirections are applied left to right
#   - `2>&1 >/dev/null |` sends only stderr down the pipe in bash; zsh's `multios` also copies
#     stdout into the pipe unless the command is wrapped in `{ }`
#   - zsh's `|&` (bash 4+ too) is short for `2>&1 |`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/milonga-salon-canning.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir library
for track in di-sarli_bahia-blanca di-sarli_organito-de-la-tarde d-arienzo_la-cumparsita \
             pugliese_la-yumba troilo_quejas-de-bandoneon; do
  print "flac audio: $track" > library/$track.flac
done

# Prints playable tracks on stdout and missing ones on stderr, like most Unix tools.
build_tanda() {
  local track
  for track in "$@"; do
    if [[ -f library/$track.flac ]]; then
      print "library/$track.flac"
    else
      print -u2 "missing: $track (still on the vinyl shelf?)"
    fi
  done
}

tanda=( di-sarli_bahia-blanca di-sarli_el-once di-sarli_organito-de-la-tarde canaro_poema )

# region: both-streams
# focus: build_tanda $tanda 2>&1
print "== on the terminal, both streams arrive together:"
build_tanda $tanda 2>&1
# endregion: both-streams

# region: split-streams
# focus: > tanda-1.m3u 2> warnings.log
build_tanda $tanda > tanda-1.m3u 2> warnings.log
print "playlist lines: $(( $(wc -l < tanda-1.m3u) )), warnings: $(( $(wc -l < warnings.log) ))"
# endregion: split-streams

# region: drop-warnings
# focus: 2>/dev/null
print "playable for the second tanda: $(build_tanda pugliese_la-yumba laurenz_milonga-de-mis-amores 2>/dev/null)"
# endregion: drop-warnings

# region: order-matters
# focus: build_tanda $tanda 2>&1 > order-b.log
build_tanda $tanda > order-a.log 2>&1
print "> order-a.log 2>&1 put $(( $(wc -l < order-a.log) )) lines in the file"
print "== 2>&1 > order-b.log: stderr already points at the old stdout, the pipe:"
{ build_tanda $tanda 2>&1 > order-b.log } | sed 's/^/  pipe got: /'
print "order-b.log got $(( $(wc -l < order-b.log) )) lines"
# endregion: order-matters

# region: errors-only-pipe
# focus: { build_tanda $crates 2>&1 >/dev/null } | wc -l
crates=( d-arienzo_la-cumparsita darienzo_paciencia troilo_quejas-de-bandoneon tanturi_una-emocion )
copied=$( build_tanda $crates 2>&1 >/dev/null | wc -l )
print "without braces, zsh's multios copies stdout into the pipe too: $(( copied )) lines"
missing=$( { build_tanda $crates 2>&1 >/dev/null } | wc -l )
print "records to pull from the shelf before midnight: $(( missing ))"
print "== |& pipes both streams, in the order they were written:"
build_tanda $crates |& sed 's/^/  /'
# endregion: errors-only-pipe
