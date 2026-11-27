#!/usr/bin/env zsh
# Quoting and parameter expansion · 13 · Amman fintech ops, resolving nested deploy config
#
# Teaches:
#   - `${(P)name}` expands the variable whose name is in `$name` (indirect expansion)
#   - `${(P)${:-${role}_host}}` builds the name first, then looks it up: `api` → `$api_host`
#   - `${(e)template}` re-evaluates `$` inside a string after you build the string
#   - `${${logpath%/*/*}##*/}` stacks trims; path modifiers `:h` `:t` walk a path without clobbering `$path`
#   - `${(%)line}` expands prompt sequences like `%D{%Y-%m-%d}` for a status line
#   - never assign to `$path` in zsh: it is tied to `$PATH`, and a string assignment wipes the PATH
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/fintech-amman.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

api_host=api.joynpay.jo
api_port=8443
worker_host=workers.joynpay.jo
worker_port=9100
staging_api_host=api.staging.joynpay.jo
typeset -A endpoints=(
  payments /v2/payments
  kyc      /v2/kyc/sessions
  ledger   /v2/ledger/entries
)

# region: indirect
# focus: ${(P)varname}
varname=api_host
print "varname holds '$varname'; (P)varname expands to: ${(P)varname}"
# endregion: indirect

# region: nested-pick
# focus: ${(P)${:-${role}_host}}
print "== hosts by role:"
for role in api worker; do
  print "  $role -> ${(P)${:-${role}_host}}:${(P)${:-${role}_port}}"
done
# endregion: nested-pick

# region: evaluate-template
# focus: ${(e)template}
env=staging
template='https://${(P)${:-${env}_api_host}}:${api_port}${endpoints[payments]}'
print "payments URL: ${(e)template}"
# endregion: evaluate-template

# region: stacked-trims
# focus: ${${logpath%/*/*}##*/}
logpaths=(
  /var/log/joynpay/api/2026-11-26/requests.jsonl
  /var/log/joynpay/worker/2026-11-26/jobs.jsonl
)
print "== service from a log path (stack two trims):"
for logpath in $logpaths; print "  ${${logpath%/*/*}##*/}  (${logpath:t})"
# endregion: stacked-trims

# region: modifiers-walk
# focus: ${logpath:h:h:t}
print "== same walk with :h (head) and :t (tail), without touching \$path:"
for logpath in $logpaths; print "  ${logpath:h:h:t}  (${logpath:t})"
# endregion: modifiers-walk

# region: prompt-escapes
# focus: ${(%)line}
role=api
line="joynpay ${role} @ ${(P)${:-${role}_host}}  [%D{%Y-%m-%d}]"
# ${(%)line} expands %D{%Y-%m-%d} to today; pin the printed date so the
# example's expected output does not change every midnight.
expanded=${(%)line}
today=${(%):-%D{%Y-%m-%d}}
print -r -- "status line: ${expanded/${today}/YYYY-MM-DD}"
# endregion: prompt-escapes
