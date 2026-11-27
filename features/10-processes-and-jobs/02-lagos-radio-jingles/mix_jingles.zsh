#!/usr/bin/env zsh
# Processes and jobs · 02 · Lagos radio station, mixing jingles as background jobs
#
# Teaches:
#   - `jobs -l` lists the shell's background jobs with process ids (redirect it; a pipe
#     runs `jobs` in a subshell and shows nothing)
#   - `%1` is job number 1; `%?mix_news` matches a job whose command contains that string
#   - `kill %?mix_news` signals that job; the shell reaps it on the next `jobs` or `wait`
#   - after a middle job exits, the remaining numbers may be `%1` and `%3`, so loop on
#     `${(k)jobtexts}` instead of assuming `%1` always exists
set -o errexit -o nounset -o pipefail
setopt extended_glob

workdir=$(mktemp -d "${TMPDIR:-/tmp}/cool-fm-lagos.XXXXXX")
typeset -a workers=()
cleanup() {
  local pid
  for pid in $workers; kill -TERM $pid 2>/dev/null || true
  wait 2>/dev/null || true
  rm -rf -- "$workdir"
}
trap cleanup EXIT
cd -- "$workdir"

zmodload zsh/parameter
for jingle in mix_sunrise mix_drive mix_news; do
  print -r -- '#!/usr/bin/env zsh
trap "exit 0" TERM
while true; do sleep 0.1; done' > $jingle
  chmod +x $jingle
done

show_board() {
  local line
  jobs -l > board.txt
  while IFS= read -r line; do
    # Keep the [n] job number; hide only the process id that follows.
    print "  ${line/(#b)(\[[0-9]##\][- +]#)[0-9]##/$match[1]PID}"
  done < board.txt
}

# region: start-jobs
# focus: ./mix_sunrise &
./mix_sunrise &
workers+=( $! )
./mix_drive &
workers+=( $! )
./mix_news &
workers+=( $! )
sleep 0.1
# endregion: start-jobs

# region: list-jobs
# focus: show_board
print "== the three jingles on the board:"
show_board
# endregion: list-jobs

# region: kill-by-name
# focus: kill %?mix_news
print "== stop the news jingle by substring:"
kill %?mix_news
sleep 0.15
jobs >/dev/null 2>&1 || true
print "  still running: ${(j:, :)${(@o)jobtexts}}"
# endregion: kill-by-name

# region: kill-by-number
# focus: kill %$n
print "== stop the remaining jobs by their numbers:"
while (( $#jobtexts )); do
  n=${${(ko)jobtexts}[1]}
  print "  killing %$n (${jobtexts[$n]})"
  kill %$n
  sleep 0.15
  jobs >/dev/null 2>&1 || true
done
workers=()
wait 2>/dev/null || true
print "  board clear: $#jobtexts jobs"
# endregion: kill-by-number
