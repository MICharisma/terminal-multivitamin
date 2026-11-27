#!/usr/bin/env zsh
# Environment and PATH · 10 · Kampala clinic IT closet, refusing a dangerous PATH
#
# Teaches:
#   - a relative `.` on PATH means the current folder is searched for every command
#   - a world-writable directory on PATH lets anyone plant a trojan `ls`
#   - test with bit arithmetic on the directory mode, the same idea as the payments-key guard
#   - rewrite PATH to the safe entries only; do not merely warn
set -o errexit -o nounset -o pipefail

if (( EUID == 0 )); then
  print -u2 "path_hygiene.zsh: run as a regular user; root ignores write bits"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/mulago-clinic.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"
zmodload -F zsh/stat b:zstat

mkdir -p safe/bin scratch
print -r -- $'#!/bin/sh\necho clinic ls\n' > safe/bin/clinic_ls
chmod +x safe/bin/clinic_ls
chmod 777 scratch
print -r -- $'#!/bin/sh\necho TROJAN\n' > scratch/clinic_ls
chmod +x scratch/clinic_ls

# region: dangerous-path
# focus: path=( . $workdir/scratch $workdir/safe/bin /usr/bin /bin )
path=( . $workdir/scratch $workdir/safe/bin /usr/bin /bin )
hash -r
print "== dangerous PATH runs the scratch trojan first:"
print "  $(clinic_ls)"
# endregion: dangerous-path

# region: audit
# focus: [[ $dir == . ]]
print "== auditing each PATH entry:"
typeset -a safe_path=()
for dir in $path; do
  if [[ $dir == . ]]; then
    print "  drop .: relative PATH entry"
    continue
  fi
  mode=$(zstat +mode -- $dir)
  if (( mode & 8#002 )); then
    print "  drop $(print -r -- $dir | sed "s|$workdir|WORK|"): world-writable"
    continue
  fi
  print "  keep $(print -r -- $dir | sed "s|$workdir|WORK|")"
  safe_path+=( $dir )
done
# endregion: audit

# region: rewrite
# focus: path=( $safe_path )
path=( $safe_path )
hash -r
print "== rewritten PATH runs the clinic tool:"
print "  $(clinic_ls)"
print "  PATH=$(print -r -- $PATH | sed "s|$workdir|WORK|g")"
# endregion: rewrite
