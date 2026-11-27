#!/usr/bin/env zsh
# zsh configuration, aliases, and functions · 12 · Stavanger offshore zstyle
#
# Teaches:
#   - `zstyle ':context:' key value` stores settings for completion and other modules
#   - `zstyle -g` reads a value back; `zstyle -L` lists them as re-runnable commands
#   - offshore desks pin completion matcher and vcs_info formats without editing functions
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/stavanger-offshore-zsh.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# region: set-zstyles
# focus: zstyle
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':vcs_info:git:*' formats '%b'
zstyle ':vcs_info:git:*' actionformats '%b|%a'
# endregion: set-zstyles

# region: read-back
# focus: zstyle
local_matcher=
zstyle -g local_matcher ':completion:*' matcher-list
print "completion matcher: $local_matcher"
# endregion: read-back

# region: list-zstyles
# focus: zstyle
print "== desk zstyles as assignable lines:"
zstyle -L ':completion:*' matcher-list
zstyle -L ':vcs_info:git:*'
# endregion: list-zstyles
