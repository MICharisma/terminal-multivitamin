#!/usr/bin/env zsh
# Pipes and redirection · 05 · Lagos family splitting a hospital bill
#
# Teaches:
#   - a here-string (`cmd <<< "$text"`) feeds one string to stdin, with no `echo |` and no temp file
#   - `IFS=: read -r name note <<< "$message"` splits a string into variables in the current shell
#   - a here-string adds a newline: `wc -c <<< "$ref"` counts one more byte than the text
#   - `tr -dc '0-9' <<< "₦1,240,000"` keeps only the digits, so `(( ))` can add naira amounts
#   - `grep -c` and `read -A` (zsh) work on a multi-line string the same way
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/okafor-family-luth.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

bill="₦1,240,000"
ref="LUTH/IDI-ARABA/2026/08841"
messages="Tunde: sent ₦400,000 from the Ikeja account
Ngozi: sent ₦310,000, receipt attached
Emeka: will send ₦250,000 on Friday
Kemi: sent ₦280,000 via transfer"

# region: digits-only
# focus: tr -dc '0-9' <<< "$bill"
total=$(tr -dc '0-9' <<< "$bill")
print "Lagos University Teaching Hospital bill: $bill, as a number: $total"
# endregion: digits-only

# region: newline-added
# focus: wc -c <<< "$ref"
print "reference $ref is ${#ref} characters; wc -c <<< sees $(( $(wc -c <<< "$ref") ))"
# endregion: newline-added

# region: count-lines
# focus: grep -c ': sent ' <<< "$messages"
print "messages in the family group: $(wc -l <<< "$messages" | tr -d ' '), already sent: $(grep -c ': sent ' <<< "$messages")"
# endregion: count-lines

# region: split-message
# focus: IFS=: read -r sibling note <<< "$message"
paid=0
for message in ${(f)messages}; do
  IFS=: read -r sibling note <<< "$message"
  amount=$(tr -dc '0-9' <<< "${${note#*₦}%% *}")
  if [[ $note == ' sent '* ]]; then
    (( paid += amount ))
    printf '  %-6s paid    %7d\n' $sibling $amount
  else
    printf '  %-6s pledged %7d\n' $sibling $amount
  fi
done
# endregion: split-message

# region: words-to-array
# focus: read -A cousins <<< "Chidi Adaeze Obinna"
read -A cousins <<< "Chidi Adaeze Obinna"
outstanding=$(( total - paid ))
print "still owed: $outstanding; if Friday slips, ${#cousins} cousins cover $(( outstanding / ${#cousins} )) each"
print "first to call: $cousins[1]"
# endregion: words-to-array
