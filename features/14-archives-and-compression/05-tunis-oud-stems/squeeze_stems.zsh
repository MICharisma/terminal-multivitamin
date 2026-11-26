#!/usr/bin/env zsh
# Archives and compression · 05 · Tunis oud recording stems
#
# Teaches:
#   - `xz` compresses a single stem file in place to `.xz`
#   - compare byte counts to prove the archive is smaller (exact xz sizes vary by version)
#   - `xz -d` restores a stem when the mix engineer needs the raw take again
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/tunis-oud.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p stems
# Fixed-length payload so raw byte counts stay identical across machines.
printf 'oud-take-%02d\n' {1..40} > stems/oud-taksim.raw
cp stems/oud-taksim.raw stems/oud-maqam.raw
cp stems/oud-taksim.raw stems/riqq-groove.raw

# region: sizes-before
# focus: wc -c
print "== before xz:"
typeset -A raw_bytes
for stem in stems/*.raw; do
  bytes=$(( $(wc -c < $stem) ))
  raw_bytes[${stem:t}]=$bytes
  print "  ${stem:t}: $bytes bytes"
done
# endregion: sizes-before

# region: xz-each
# focus: xz $stem
for stem in stems/*.raw; do
  xz $stem
done
print "== after xz (each smaller than its raw stem):"
for packed in stems/*.xz; do
  bytes=$(( $(wc -c < $packed) ))
  raw_name=${packed:t:r}
  if (( bytes < raw_bytes[$raw_name] )); then
    print "  ${packed:t}: smaller"
  else
    print "  ${packed:t}: not smaller"
  fi
done
# endregion: xz-each

# region: xz-restore
# focus: xz -d stems/oud-taksim.raw.xz
xz -d stems/oud-taksim.raw.xz
print "== restored oud-taksim:"
print "  $(( $(wc -c < stems/oud-taksim.raw) )) bytes"
print "== remaining archives:"
ls -1 stems
# endregion: xz-restore
