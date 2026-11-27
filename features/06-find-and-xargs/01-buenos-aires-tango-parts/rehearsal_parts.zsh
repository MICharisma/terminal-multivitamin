#!/usr/bin/env zsh
# Finding files with find and xargs · 01 · Buenos Aires tango orchestra, pulling parts for rehearsal
#
# Teaches:
#   - `find dir -name '*.pdf'` tests the file name only, and case matters
#   - `-iname` ignores case, so the copyist's `contrabajo.PDF` turns up too
#   - `-type f` keeps a folder called `piano-arreglos/` out of a list of piano parts
#   - `-o` binds looser than the implied "and", so `a -o b -print` prints only `b`;
#     `\( a -o b \) -print` prints both
#   - `find` lists in directory order, not alphabetical order; pipe it to `sort`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/orquesta-tipica.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p repertorio/{la-cumparsita,libertango,adios-nonino/piano-arreglos}
for part in la-cumparsita/bandoneon-1.pdf la-cumparsita/violin-1.pdf la-cumparsita/piano.pdf \
            libertango/bandoneon-1.pdf adios-nonino/piano.pdf; do
  print "${part%%/*}: ${${part:t}:r} part, arrangement for orquesta típica" > repertorio/$part
done
print "contrabajo part, scanned by the copyist at 300 dpi" > repertorio/la-cumparsita/contrabajo.PDF
print "MuseScore source of the new Libertango arrangement" > repertorio/libertango/piano.mscz
print "Thursday rehearsal at 20:00, Almagro" > repertorio/notas.txt

# region: by-name
# focus: find repertorio -name '*.pdf'
exact=( ${(f)"$(find repertorio -name '*.pdf' | sort)"} )
print "with -name: $#exact parts"
# endregion: by-name

# region: any-case
# focus: find repertorio -iname '*.pdf'
any_case=( ${(f)"$(find repertorio -iname '*.pdf' | sort)"} )
missed=( ${any_case:|exact} )
print "with -iname: $#any_case parts, adding $missed"
# endregion: any-case

# region: files-only
# focus: find repertorio -type f -name 'piano*'
print "== -name 'piano*' also matches a folder:"
find repertorio -name 'piano*' | sort
print "== add -type f for files only:"
find repertorio -type f -name 'piano*' | sort
# endregion: files-only

# region: precedence
# focus: \( -iname '*.pdf' -o -name '*.mscz' \)
print "== without parentheses, -print belongs to the -mscz test alone:"
find repertorio -iname '*.pdf' -o -name '*.mscz' -print | sort
print "== grouped, everything the orchestra can open:"
find repertorio \( -iname '*.pdf' -o -name '*.mscz' \) -print | sort
# endregion: precedence
