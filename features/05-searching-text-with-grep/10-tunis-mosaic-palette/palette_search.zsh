#!/usr/bin/env zsh
# Searching text with grep · 10 · Tunis mosaic workshop, searching only the palette files
#
# Teaches:
#   - GNU `grep --include='*.csv'` limits a recursive search to matching file names
#   - `--exclude='*.md'` skips matching names; `--exclude-dir=` skips whole folders
#   - BSD grep (macOS) has no `--include`; detect GNU once, or fall back to `find … -exec grep`
#   - the portable form shown here keeps the lesson working on both flavours
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/atelier-medina.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -R -- $here/fixtures/panel-a $here/fixtures/panel-b $workdir/
cd -- "$workdir"

# region: detect-gnu
# focus: grep --help
if grep --help 2>&1 | grep -q -- '--include'; then
  grep_flavour=GNU
else
  grep_flavour=BSD
fi
print "grep flavour: $grep_flavour"
# endregion: detect-gnu

# region: include-csv
# focus: --include='*.csv'
print "== ochre rows in palette.csv files only:"
if [[ $grep_flavour == GNU ]]; then
  grep -r --include='*.csv' ochre . | sort
else
  find . -name '*.csv' -exec grep -H ochre {} + | sort
fi
# endregion: include-csv

# region: exclude-md
# focus: --exclude='*.md'
print "== ochre anywhere except the notes:"
if [[ $grep_flavour == GNU ]]; then
  grep -r --exclude='*.md' ochre . | sort
else
  find . ! -name '*.md' -type f -exec grep -H ochre {} + | sort
fi
# endregion: exclude-md

# region: portable-find
# focus: find . -name '*.csv' -exec grep -H
print "== portable find form (same answer on both greps):"
find . -name '*.csv' -exec grep -H gold-glass {} + || print "(no gold-glass in these panels)"
# endregion: portable-find
