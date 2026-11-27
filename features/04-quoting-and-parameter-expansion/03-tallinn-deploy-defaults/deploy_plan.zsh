#!/usr/bin/env zsh
# Quoting and parameter expansion · 03 · Tallinn parcel-locker startup, deploy settings with defaults
#
# Teaches:
#   - `${var:-default}` uses the default when the variable is unset or empty; `${var-default}` only when unset
#   - `${var:=default}` also assigns the default, so later lines see it
#   - `${var:?message}` stops the script with the message when a required setting is missing
#   - `${var:+value}` gives `value` only when the variable is set, which adds an optional flag to a command
#   - `VAR=value function` sets a variable for one call only
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/pakiautomaat-deploy.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

unset DEPLOY_REGION REPLICAS RELEASE_CHANNEL SLACK_WEBHOOK DATABASE_URL

# region: colon-dash
# focus: ${DEPLOY_REGION:-eu-north-1}
region_for() { print "region: ${DEPLOY_REGION:-eu-north-1}" }
print "unset:          $(region_for)"
print "empty:          $(DEPLOY_REGION= region_for)"
print "set to Riga DC: $(DEPLOY_REGION=eu-central-riga region_for)"
# endregion: colon-dash

# region: dash-only
# focus: ${REPLICAS-2}
replicas_for() { print "replicas: '${REPLICAS-2}' with -, '${REPLICAS:-2}' with :-" }
print "unset: $(replicas_for)"
print "empty: $(REPLICAS= replicas_for)"
# endregion: dash-only

# region: assign-default
# focus: : ${RELEASE_CHANNEL:=stable}
: ${RELEASE_CHANNEL:=stable}
print "release channel, assigned once and kept: $RELEASE_CHANNEL"
# endregion: assign-default

# region: optional-flag
# focus: ${SLACK_WEBHOOK:+--notify=$SLACK_WEBHOOK}
command_for() {
  local -a deploy=( flyctl deploy --region ${DEPLOY_REGION:-eu-north-1} ${SLACK_WEBHOOK:+--notify=$SLACK_WEBHOOK} )
  print "${#deploy} words: $deploy"
}
print "no webhook:   $(command_for)"
print "with webhook: $(SLACK_WEBHOOK=https://hooks.slack.example/T0/lockers command_for)"
# endregion: optional-flag

# region: required-setting
# focus: ${DATABASE_URL:?set DATABASE_URL to the Postgres connection string}
migrate() { print "migrating ${DATABASE_URL:?set DATABASE_URL to the Postgres connection string}" }
if ! message=$( (migrate) 2>&1 ); then
  print "stopped before migrating: ${message#*DATABASE_URL: }"
fi
print "$(DATABASE_URL=postgres://lockers@db.tallinn.internal/prod migrate)"
# endregion: required-setting
