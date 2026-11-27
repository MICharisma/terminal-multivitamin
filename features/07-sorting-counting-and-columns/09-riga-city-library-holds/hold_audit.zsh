#!/usr/bin/env zsh
# Sorting, counting, and columns · 09 · Riga city library, auditing holds against the patron directory
#
# Teaches:
#   - `join` needs both files sorted on the join field; `sort -k1,1` prepares them
#   - plain `join` is an inner join: only cards present in both files
#   - `join -v1` lists left-only rows; `join -v2` lists right-only rows
#   - together, the matches plus both `-v` lists are an outer join, without GNU `-o auto`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/pilelic-library.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- ${0:A:h}/fixtures/{holds-on-shelf.tsv,patron-directory.tsv} $workdir/
cd -- "$workdir"

sort -k1,1 holds-on-shelf.tsv > holds-sorted.tsv
sort -k1,1 patron-directory.tsv > patrons-sorted.tsv

# region: inner-join
# focus: join -t $'\t' holds-sorted.tsv patrons-sorted.tsv
print "== cards on both the shelf and the directory:"
join -t $'\t' holds-sorted.tsv patrons-sorted.tsv |
  while IFS=$'\t' read -r card h_bar hold_name p_bar dir_name; do
    print "  $card: $hold_name"
  done
# endregion: inner-join

# region: outer-join
# focus: join -v2 -t $'\t'
print "== every card in either holds or the directory:"
{
  join -t $'\t' holds-sorted.tsv patrons-sorted.tsv |
    while IFS=$'\t' read -r card h_bar hold_name p_bar dir_name; do
      print "  $card: shelf and directory agree on $hold_name"
    done
  join -v1 -t $'\t' holds-sorted.tsv patrons-sorted.tsv |
    while IFS=$'\t' read -r card barcode name; do
      print "  $card: on shelf only, $name"
    done
  join -v2 -t $'\t' holds-sorted.tsv patrons-sorted.tsv |
    while IFS=$'\t' read -r card barcode name; do
      print "  $card: on directory only, $name"
    done
} | sort
# endregion: outer-join

# region: unmatched-left
# focus: join -v1 -t $'\t'
print "== holds with no matching patron record:"
join -v1 -t $'\t' holds-sorted.tsv patrons-sorted.tsv |
  while IFS=$'\t' read -r card barcode name; do
    print "  $card ($barcode): $name — no row in patron-directory.tsv"
  done
# endregion: unmatched-left
