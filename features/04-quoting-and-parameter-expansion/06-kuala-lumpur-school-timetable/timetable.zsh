#!/usr/bin/env zsh
# Quoting and parameter expansion · 06 · Kuala Lumpur secondary school, splitting the timetable
#
# Teaches:
#   - `${(f)"$(<file)"}` splits a file's contents into an array of lines
#   - `${(s:,:)periods}` splits a string on commas, and drops empty fields
#   - `"${(@s:,:)periods}"`, quoted with `@`, keeps the empty fields, so period numbers stay right
#   - `${(j: | :)array}` joins an array with a separator; `${(F)array}` joins with newlines
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/smk-bukit-bintang.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- $here/fixtures/timetable.txt $workdir/
cd -- "$workdir"

# region: split-lines
# focus: ${(f)"$(<timetable.txt)"}
classes=( ${(f)"$(<timetable.txt)"} )
print "classes on Monday's timetable: ${#classes}"
# endregion: split-lines

# region: split-drops-empty
# focus: ${(s:,:)periods}
line=$classes[1]
periods=${line#*:}
dropped=( ${(s:,:)periods} )
print "${line%%:*}: (s:,:) gives ${#dropped} subjects, and period 4 looks like: $dropped[4]"
# endregion: split-drops-empty

# region: split-keeps-empty
# focus: "${(@s:,:)periods}"
kept=( "${(@s:,:)periods}" )
print "${line%%:*}: \"\${(@s:,:)...}\" keeps ${#kept} periods; period 4 is '${kept[4]}' (assembly in the hall)"
# endregion: split-keeps-empty

# region: join-for-display
# focus: ${(j: | :)subjects}
print "== Monday, periods 1 to 7:"
for line in $classes; do
  subjects=( "${(@s:,:)${line#*:}}" )
  subjects=( ${subjects/#%/(assembly)} )
  print "  ${(r:12:)${line%%:*}} ${(j: | :)subjects}"
done
# endregion: join-for-display

# region: join-lines
# focus: ${(F)maths_classes}
maths_classes=()
for line in $classes; do
  subjects=( "${(@s:,:)${line#*:}}" )
  (( ${subjects[(I)Maths]} )) && maths_classes+=( "${line%%:*}, period ${subjects[(i)Maths]}" )
done
print "== first Maths period, for Cikgu Farah's notice board:"
print -r -- ${(F)maths_classes}
# endregion: join-lines
