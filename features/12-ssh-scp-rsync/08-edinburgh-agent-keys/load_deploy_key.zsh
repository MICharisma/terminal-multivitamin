#!/usr/bin/env zsh
# ssh, scp, and rsync · 08 · Edinburgh fintech desk agent keys
#
# Teaches:
#   - `ssh-agent` holds decrypted keys in memory for a session
#   - `ssh-add` loads a private key into that agent
#   - `ssh-add -l` lists the loaded keys (here: only the comment)
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/fintech-deploy.XXXXXX")
agent_pid=
cleanup() {
  [[ -n $agent_pid ]] && kill $agent_pid 2>/dev/null
  rm -rf -- "$workdir"
}
trap cleanup EXIT
cd -- "$workdir"

mkdir -p keys
ssh-keygen -t ed25519 -f keys/deploy-prod -N '' -C deploy@leith-fintech.scot -q

# region: start-agent
# focus: ssh-agent
agent_out=$(
  eval "$(ssh-agent -s)" >/dev/null
  print -r -- $SSH_AGENT_PID
  print -r -- $SSH_AUTH_SOCK
)
agent_pid=${agent_out[(f)1]}
export SSH_AUTH_SOCK=${agent_out[(f)2]}
print "agent: running"
# endregion: start-agent

# region: add-key
# focus: ssh-add
(
  export SSH_AUTH_SOCK
  ssh-add keys/deploy-prod 2>/dev/null
  print "added: deploy-prod"
)
# endregion: add-key

# region: list-keys
# focus: ssh-add -l
(
  export SSH_AUTH_SOCK
  print "== loaded:"
  ssh-add -l | awk '{print $3}'
)
# endregion: list-keys
