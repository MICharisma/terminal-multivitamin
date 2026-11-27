#!/usr/bin/env zsh
# Sorting, counting, and columns · 03 · Turin classic car workshop, cutting columns from a parts catalogue
#
# Teaches:
#   - `cut -c1-8` and `cut -c48-` take character columns, the right tool for a fixed-width printout
#   - `cut -d' '` treats every single space as a separator, so padded columns come out empty
#   - `cut -f` splits on tabs by default; `-s` drops lines with no tab, such as a comment header
#   - `cut` always prints fields in file order: `-f4,2` is the same as `-f2,4`
#   - `-f1,3-` keeps every field but the second; GNU's `--complement -f2` is not in BSD `cut`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/officina-ricambi.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- ${0:A:h}/fixtures/{catalogo-ricambi.txt,work-orders.tsv} $workdir/
cd -- "$workdir"

# region: fixed-width
# focus: cut -c48-
print "== part codes and prices from the supplier's printout:"
paste -d' ' <(cut -c1-8 catalogo-ricambi.txt) <(cut -c48- catalogo-ricambi.txt) | tail -n +2
# endregion: fixed-width

# region: space-delimiter
# focus: cut -d' ' -f2
print "with cut -d' ' -f2 the second field of each part line is empty: [$(sed -n 2p catalogo-ricambi.txt | cut -d' ' -f2)]"
print "and -f3 is only the first word of a description: [$(sed -n 4p catalogo-ricambi.txt | cut -d' ' -f3)]"
# endregion: space-delimiter

# region: tab-fields
# focus: cut -s -f2,4 work-orders.tsv
print "== part and mechanic for each work order, comment line dropped by -s:"
cut -s -f2,4 work-orders.tsv
# endregion: tab-fields

# region: no-reorder
# focus: cut -s -f4,2 work-orders.tsv
if [[ $(cut -s -f4,2 work-orders.tsv) == $(cut -s -f2,4 work-orders.tsv) ]]; then
  print "cut -f4,2 printed the same columns in the same order as -f2,4"
fi
print "== mechanic first, by reading the fields instead:"
cut -s -f2,4 work-orders.tsv | while IFS=$'\t' read -r part mechanic; do
  print "  $mechanic: $part"
done
# endregion: no-reorder

# region: all-but-one
# focus: cut -s -f1,3-
print "== for the customer copy, everything but the part code:"
cut -s -f1,3- work-orders.tsv
# endregion: all-but-one
