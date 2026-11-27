#!/usr/bin/env zsh
# Permissions and ownership · 05 · Hobart Antarctic research lab, choosing a umask for ice core data
#
# Teaches:
#   - `umask` removes bits from new files (which start at 666) and new folders (777)
#   - `$(( 8#666 & ~8#027 ))` predicts the mode; `printf %03o` prints it as octal
#   - `umask -S` shows the same mask as the bits that are *kept*: `u=rwx,g=rx,o=`
#   - a `( subshell )` scopes a umask change to one block
#   - a umask only takes bits away; `mkdir -m` and `chmod` afterwards still set what they say
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/aad-ice-cores.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

zmodload -F zsh/stat b:zstat
umask 022
mode_of() { local m; zstat -A m -o +mode -- $1; print ${m[1][-3,-1]} }

# region: masks-to-try
# focus: typeset -A purpose=( 022
typeset -A purpose=( 022 "public outreach images"  027 "project group only"  077 "embargoed until publication" )
# endregion: masks-to-try

# region: predict-and-create
# focus: umask $mask
printf '%-5s %-16s %-9s %-10s %-10s %s\n' umask "umask -S" predicted file folder purpose
for mask in ${(ok)purpose}; do
  (
    umask $mask
    mkdir core-$mask
    print "core DSS-2026-$mask, depth 112.4-113.4 m, d18O -33.1" > core-$mask/section.csv
    predicted_file=$(printf %03o $(( 8#666 & ~8#$mask )))
    predicted_dir=$(printf %03o $(( 8#777 & ~8#$mask )))
    [[ $(mode_of core-$mask/section.csv) == $predicted_file && $(mode_of core-$mask) == $predicted_dir ]]
    printf '%-5s %-16s %-9s %-10s %-10s %s\n' $mask $(umask -S) $predicted_file/$predicted_dir \
      $(zstat -s +mode -- core-$mask/section.csv) $(zstat -s +mode -- core-$mask) $purpose[$mask]
  )
done
# endregion: predict-and-create

# region: scoped
# focus: umask
print "back outside the subshells, this script's umask is still $(umask)"
# endregion: scoped

# region: mask-only-removes
# focus: mkdir -m 775 shared-with-glaciology
(
  umask 077
  mkdir -m 775 shared-with-glaciology
  print "radar log, Law Dome traverse" > radar.log
  chmod 664 radar.log
  print "with umask 077, mkdir -m 775 still gives $(mode_of shared-with-glaciology), chmod 664 gives $(mode_of radar.log)"
)
(
  umask 000
  print "core inventory" > inventory.txt
  print "umask 000 still gives new files $(mode_of inventory.txt): no x bit appears from nowhere"
)
# endregion: mask-only-removes
