#!/usr/bin/env zsh
# Pipes and redirection · 11 · Bogotá university library, renewing loans in a batch
#
# Teaches:
#   - a command inside `while read ...; done < file` shares the loop's stdin, and can swallow
#     the rest of the file (ssh, ffmpeg, and many CLIs that read input do exactly this)
#   - `< /dev/null` gives such a command an empty stdin; reading the loop from descriptor 3
#     (`read -u 3 ... done 3< file`) leaves stdin alone altogether
#   - `> /dev/null 2>&1` throws output away when only the exit status matters
#   - `: > file` empties a file in place, keeping its permissions
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/biblioteca-unal.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

print -l "1020304050 QA76.73.Z34 Learning zsh" \
         "1033445566 PQ8180.17 Cien años de soledad" \
         "1099887766 TK7885 Arquitectura de computadores" \
         "1011223344 QH541 Ecología de páramos" > loans.txt

# Like many command-line tools, the renewal client reads an optional note from stdin
# whenever stdin is not a terminal.
renew() {
  local note
  [[ -t 0 ]] && note= || note=$(cat)
  print "renewed $2 for student $1${note:+, note read from stdin: ${note%%$'\n'*}}" >> renewals.log
}

# region: swallowed-stdin
# focus: done < loans.txt
while read -r student call_number title; do
  renew $student $call_number
done < loans.txt
print "renewals with a plain loop: $(( $(wc -l < renewals.log) )) of 4"
sed 's/^/  /' renewals.log
# endregion: swallowed-stdin

# region: truncate-log
# focus: : > renewals.log
: > renewals.log
print "renewals.log emptied: $(( $(wc -c < renewals.log) )) bytes"
# endregion: truncate-log

# region: dev-null-stdin
# focus: renew $student $call_number < /dev/null
while read -r student call_number title; do
  renew $student $call_number < /dev/null
done < loans.txt
print "renewals with < /dev/null: $(( $(wc -l < renewals.log) )) of 4"
# endregion: dev-null-stdin

# region: loop-on-fd3
# focus: done 3< loans.txt
: > renewals.log
while read -r -u 3 student call_number title; do
  renew $student $call_number <<< "overdue fine waived by Prof. Rojas"
done 3< loans.txt
print "renewals reading the loop from descriptor 3, each with its own note: $(( $(wc -l < renewals.log) )) of 4"
tail -n 1 renewals.log | sed 's/^/  /'
# endregion: loop-on-fd3

# region: status-only
# focus: > /dev/null 2>&1
if grep 'PQ8180' renewals.log > /dev/null 2>&1; then
  print "García Márquez is renewed; nothing printed by grep, only its exit status used"
fi
if ! command -v koha-renew > /dev/null 2>&1; then
  print "no koha-renew on this machine, so the batch used the local stand-in"
fi
# endregion: status-only
