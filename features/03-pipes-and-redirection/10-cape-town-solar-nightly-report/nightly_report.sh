#!/bin/sh
# Pipes and redirection · 10 · Cape Town solar installer's nightly report, in portable sh
#
# Teaches:
#   - `exec 3>&1 4>&2` keeps copies of the terminal's stdout and stderr as descriptors 3 and 4
#   - `exec >report.log 2>&1` (no command) redirects the rest of the script; `exec 1>&3 2>&4` undoes it
#   - `{ ...; } >> file` redirects a whole group of commands once instead of line by line
#   - `>&2` sends a warning to stderr; `2>>errors.log` collects them
#   - `&>file` is bash and zsh only: dash reads `cmd &>file` as `cmd &` plus `>file`, so POSIX
#     scripts write `>file 2>&1`
set -eu

workdir=$(mktemp -d "${TMPDIR:-/tmp}/sunbird-solar.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

check_site() {
  site=$1 kwh=$2
  if [ "$kwh" -lt 10 ]; then
    echo "WARN $site: only $kwh kWh, check for load-shedding trips or dirty panels" >&2
  fi
  echo "$site $kwh kWh"
}

# region: save-stdout
# focus: exec 3>&1 4>&2
exec 3>&1 4>&2
echo "starting nightly report (this line goes to the terminal)"
# endregion: save-stdout

# region: redirect-script
# focus: exec >report.log 2>&1
exec >report.log 2>&1
echo "== Sunbird Solar, installs reporting tonight"
check_site khayelitsha-library 23
check_site stellenbosch-winery 41
check_site muizenberg-surf-school 6
# endregion: redirect-script

# region: restore-stdout
# focus: exec 1>&3 2>&4 3>&- 4>&-
exec 1>&3 2>&4 3>&- 4>&-
echo "back on the terminal; report.log has $(wc -l < report.log | tr -d ' ') lines:"
sed 's/^/  /' report.log
# endregion: restore-stdout

# region: group-redirect
# focus: } >> monthly.log 2>> errors.log
{
  echo "== second inverter batch"
  check_site langa-clinic 18
  check_site hout-bay-harbour 4
} >> monthly.log 2>> errors.log
echo "monthly.log: $(wc -l < monthly.log | tr -d ' ') lines, errors.log: $(wc -l < errors.log | tr -d ' ') line"
sed 's/^/  /' errors.log
# endregion: group-redirect
