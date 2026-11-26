#!/usr/bin/env zsh
# Permissions and ownership · 01 · Bengaluru hosting support desk, decoding a pasted `ls -l`
#
# Teaches:
#   - the first character of an `ls -l` mode is the type: `-` file, `d` folder,
#     `l` symlink, `c` character device
#   - the next nine are three triads (owner, group, others); `r`=4, `w`=2, `x`=1
#     add up to one octal digit each
#   - `s` in the owner triad means setuid plus execute, `S` setuid without execute,
#     and `t` in the others triad is the sticky bit
#   - a trailing `+` means an ACL is attached (macOS also shows `@` for extended attributes)
#   - world-writable files, and world-writable folders without the sticky bit, are the
#     lines to raise with the customer
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/support-desk.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- $here/fixtures/ticket-48213_ls-l.txt $workdir/
cd -- "$workdir"

typeset -A kind=( - file  d folder  l symlink  c device  b block-device  p fifo  s socket )

triad_digit() {
  local triad=$1 digit=0
  [[ $triad[1] == r ]] && (( digit += 4 ))
  [[ $triad[2] == w ]] && (( digit += 2 ))
  [[ $triad[3] == [xst] ]] && (( digit += 1 ))
  print $digit
}

print "ticket 48213, customer's listing of /srv/shop:"
printf '%-16s %-11s %-8s %-5s %s\n' name mode type octal notes
while IFS= read -r line; do
  [[ $line == total\ * ]] && continue

  # region: split-columns
  # focus: ${words[(i)(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)]}
  words=( ${=line} )
  mode=$words[1]
  month=${words[(i)(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)]}
  entry=${(j: :)words[month+3,-1]}
  name=${entry%% -> *}
  # endregion: split-columns

  # region: type-char
  # focus: $kind[$mode[1]]
  type=$kind[$mode[1]]
  # endregion: type-char

  # region: triads-to-octal
  # focus: $(triad_digit $mode[2,4])
  octal=$(triad_digit $mode[2,4])$(triad_digit $mode[5,7])$(triad_digit $mode[8,10])
  # endregion: triads-to-octal

  # region: special-bits
  # focus: [[ $mode[4] == [sS] ]]
  special=0 notes=()
  [[ $mode[4] == [sS] ]] && { (( special += 4 )); notes+=( setuid ) }
  [[ $mode[7] == [sS] ]] && { (( special += 2 )); notes+=( setgid ) }
  [[ $mode[10] == [tT] ]] && { (( special += 1 )); notes+=( sticky ) }
  [[ $mode[4] == S ]] && notes+=( "(S: setuid but not executable, a typo?)" )
  (( special )) && octal=$special$octal
  [[ $mode[11,-1] == + ]] && notes+=( "has an ACL, see getfacl" )
  [[ $type == symlink ]] && notes+=( "-> ${entry#* -> }, the link's own mode is ignored" )
  # endregion: special-bits

  # region: flag-risks
  # focus: $mode[9] == w
  if [[ $type == (file|folder) && $mode[9] == w ]]; then
    if [[ $type == folder && $mode[10] == [tT] ]]; then
      notes+=( "world-writable but sticky: fine, like /tmp" )
    else
      notes+=( "WORLD-WRITABLE: anyone on the server can change this" )
    fi
  fi
  # endregion: flag-risks

  row=$(printf '%-16s %-11s %-8s %-5s %s' $name $mode $type $octal "${(j:; :)notes}")
  print -r -- ${row%"${row##*[^ ]}"}
done < ticket-48213_ls-l.txt
