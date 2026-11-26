#!/usr/bin/env zsh
# Homebrew · 10 · Québec City SaaS brew services board
#
# Teaches:
#   - `brew services list` shows formulae Homebrew can run as background services
#   - an associative array keyed by formula holds status for a standup board
#   - this example only reads the list; it never starts or stops a service
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/hiver-saas-brew.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -R -- $here/fixtures/. $workdir/
cd -- "$workdir"
PATH=$workdir/bin:$PATH

typeset -A service_status

# region: services-list
# focus: brew services list
while IFS= read -r line; do
  [[ $line == Name* || -z $line ]] && continue
  typeset -a columns
  columns=( ${=line} )
  service_status[$columns[1]]=$columns[2]
done < <(brew services list)
# endregion: services-list

# region: board
# focus: service_status
print "== Hiver standup service board:"
for name in ${(ko)service_status}; do
  print "  ${(r:14:)name} ${service_status[$name]}"
done
# endregion: board
