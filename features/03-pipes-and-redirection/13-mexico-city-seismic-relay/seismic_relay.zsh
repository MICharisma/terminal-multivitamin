#!/usr/bin/env zsh
# Pipes and redirection · 13 · Mexico City seismic alert relay
#
# Teaches:
#   - `mkfifo` makes a named pipe: a background writer and a reader meet there, and nothing piles up on disk
#   - opening a fifo waits until both ends are open; `wait $writer` collects the writer's exit status
#   - `exec {audit}>>audit.log` (zsh, bash 4.1+) picks a free descriptor and stores its number in `$audit`
#   - `$( cmd 2>&1 1>&$terminal )` captures only the warnings, while normal output goes to the saved stdout
#   - a here-doc loads the station thresholds; `{ ... } | tee` prints the bulletin and files it
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/sasmex-relay.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# region: load-thresholds
# focus: done <<'THRESHOLDS'
typeset -A limit_mg
while read -r station mg; do
  limit_mg[$station]=$mg
done <<'THRESHOLDS'
CU-UNAM 40
TLATELOLCO 25
XOCHIMILCO 20
THRESHOLDS
# endregion: load-thresholds

# Stands in for the accelerometer feed: station, peak ground acceleration in milli-g.
stream_readings() {
  print -l "CU-UNAM 12" "TLATELOLCO 31" "XOCHIMILCO 9" "CU-UNAM 44" "XOCHIMILCO 26" "TLATELOLCO 18"
}

# region: fifo-writer
# focus: mkfifo readings.fifo
mkfifo readings.fifo
stream_readings > readings.fifo &
writer=$!
# endregion: fifo-writer

# region: open-descriptors
# focus: exec {audit}>>audit.log {terminal}>&1
exec {audit}>>audit.log {terminal}>&1
# endregion: open-descriptors

# Routine readings go to stdout, threshold breaches to stderr, and every line to the audit log.
classify() {
  local station mg
  while read -r station mg; do
    print -u $audit "$station $mg mg"
    if (( mg > limit_mg[$station] )); then
      print -u2 "ALERT $station ${mg} mg (limit $limit_mg[$station])"
    else
      print "  routine: $station $mg mg"
    fi
  done
}

# region: capture-alerts
# focus: alerts=( ${(f)"$( classify < readings.fifo 2>&1 1>&$terminal )"} )
print "== relay running; routine readings pass straight through:"
alerts=( ${(f)"$( classify < readings.fifo 2>&1 1>&$terminal )"} )
wait $writer && print "accelerometer feed closed cleanly (exit $?)"
# endregion: capture-alerts

# region: bulletin
# focus: } | tee alert-bulletin.txt
{
  print "== bulletin for Protección Civil: ${#alerts} stations over their limit"
  print -l "  "$^alerts
} | tee alert-bulletin.txt
# endregion: bulletin

# region: close-descriptors
# focus: exec {audit}>&- {terminal}>&-
exec {audit}>&- {terminal}>&-
print "audit.log: $(( $(wc -l < audit.log) )) readings; bulletin filed: $(( $(wc -l < alert-bulletin.txt) )) lines"
[[ -p readings.fifo ]] && print "readings.fifo is still a named pipe (type $(ls -l readings.fifo | cut -c1)), holding no data"
# endregion: close-descriptors
