#!/usr/bin/env zsh
# Globbing and expansion · 02 · Cusco Quechua language school course folders
#
# Teaches:
#   - brace expansion {a,b} and sequences {01..06} generate words before any
#     file exists; nested braces multiply into every combination
#   - {01..12..3} steps a sequence; zero padding follows the first number
#   - brace expansion invents names, globbing only finds existing ones
#   - (/) after a glob keeps directories only (more in slot 04)
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/yachay-wasi.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# region: build-units
# focus: units/unidad-{01..06}/{lecciones,audio,examenes}
mkdir -p units/unidad-{01..06}/{lecciones,audio,examenes}
course_dirs=( units/*/*(/) )
print "folders created: ${#course_dirs}"
print -l units/unidad-01/*
# endregion: build-units

# region: schedule-words
# focus: {lunes,miercoles,viernes}-{maniana,tarde}
print "== class slots for the term:"
print -l -- {lunes,miercoles,viernes}-{maniana,tarde}
# endregion: schedule-words

# region: stepped-sequence
# focus: {01..12..3}
print "== review weeks (every third week):" week-{01..12..3}
# endregion: stepped-sequence

# region: braces-versus-globs
# focus: units/unidad-0[78](N)
print "== braces name units that do not exist yet:" units/unidad-{07..08}
matches=( units/unidad-0[78](N) )
print "== a glob for the same units finds ${#matches} folders"
# endregion: braces-versus-globs
