#!/usr/bin/env zsh
# Archives and compression · 13 · Sarajevo ballot bundle
#
# Teaches:
#   - a small function library packs, checksums, verifies, and extracts one bundle
#   - `tar -czf` plus `shasum -a 256` seal the ballots; verify before `tar -xzf`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/sarajevo-ballots.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p ballots
print "station: Centar, box 12, counted 08:00" > ballots/centar-box-12.txt
print "station: Novo Sarajevo, box 03"         > ballots/novo-box-03.txt
print "station: Stari Grad, box 07"            > ballots/stari-box-07.txt

# region: pack-fn
# focus: tar -czf
pack_ballots() {
  emulate -L zsh
  setopt local_options err_return
  local archive=$1
  shift
  tar -czf $archive "$@"
  print "packed $archive (${#} station files)"
}
# endregion: pack-fn

# region: seal-fn
# focus: shasum -a 256
seal_bundle() {
  emulate -L zsh
  setopt local_options err_return
  local archive=$1 manifest=$2
  shasum -a 256 $archive > $manifest
  print "sealed $(awk '{print $2}' $manifest)"
}
# endregion: seal-fn

# region: verify-fn
# focus: shasum -c
verify_bundle() {
  emulate -L zsh
  setopt local_options err_return
  local manifest=$1
  shasum -c $manifest
}
# endregion: verify-fn

# region: extract-fn
# focus: tar -xzf
extract_ballots() {
  emulate -L zsh
  setopt local_options err_return
  local archive=$1 dest=$2
  mkdir -p $dest
  tar -xzf $archive -C $dest
  print "extracted into $dest:"
  ls -1 $dest/ballots
}
# endregion: extract-fn

# region: run-workflow
# focus: pack_ballots
print "== election night workflow:"
pack_ballots election-night.tgz ballots/*.txt
seal_bundle election-night.tgz election-night.sha256
rm -rf ballots
print "== verify before opening:"
verify_bundle election-night.sha256
extract_ballots election-night.tgz opened
# endregion: run-workflow
