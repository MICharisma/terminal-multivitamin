#!/usr/bin/env zsh
# Permissions and ownership · 10 · Cape Town sea rescue station, handing files to the station account
#
# Teaches:
#   - `ls -n` shows the owner and group as numbers; compare them with `id -u` and `id -G`
#   - you may `chgrp` your own file to a group you belong to, and `chown` it to yourself
#   - giving a file to another user, or to a group you are not in, needs root: "Operation not permitted"
#   - only the owner may `chmod` a file, and `[[ -O f ]]` tests that without trying
#   - collect the commands that need `sudo` into a plan, quote them with `${(q-)...}`, and let a
#     person review and run them; the script itself never calls `sudo`
set -o errexit -o nounset -o pipefail

if (( EUID == 0 )); then
  print -u2 "handover_plan.zsh: run this as a regular user; root may give files away"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/nsri-station8.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p handover/{launch-logs,crew}
print "2026-11-22 14:05 launch, Spirit of Hout Bay, kayaker 2 nm off Kommetjie, recovered" > handover/launch-logs/2026-11.txt
print "skipper: Thandiwe M., crew: Pieter V., Aisha D., Sipho N." > handover/crew/roster-december.txt
print "VHF channel 16 watch, Sentinel Peak repeater" > "handover/crew/radio notes.txt"

my_groups=( ${=$(id -G)} )
for gid in {0..60}; do
  (( ${my_groups[(Ie)$gid]} )) || { outsider_gid=$gid; break }
done

# region: numeric-owner
# focus: ls -n
read -r mode links owner_uid owner_gid rest <<< "$(ls -n handover/launch-logs/2026-11.txt)"
print "== who owns the launch log:"
(( owner_uid == $(id -u) )) && print "  the owner number is my id -u"
(( ${my_groups[(Ie)$owner_gid]} )) && print "  the group number is one of my id -G"
# endregion: numeric-owner

# region: allowed-changes
# focus: chgrp $(id -g) handover/launch-logs/2026-11.txt
chown $(id -u) handover/launch-logs/2026-11.txt
chgrp $(id -g) handover/launch-logs/2026-11.txt
print "  chown to myself, chgrp to my own group: allowed"
# endregion: allowed-changes

# region: refused-changes
# focus: chown 0 handover/crew/roster-december.txt
attempt() {
  local label=$1; shift
  if "$@" 2>/dev/null; then print "  $label: allowed"; else print "  $label: Operation not permitted"; fi
}
attempt "chown to root" chown 0 handover/crew/roster-december.txt
attempt "chgrp to a group I am not in" chgrp $outsider_gid handover/crew/roster-december.txt
# endregion: refused-changes

# region: test-first
# focus: [[ -O $file ]]
print "== files I can still chmod, because I own them:"
for file in handover/**/*(.); do
  [[ -O $file ]] && print "  ${file#handover/}"
done
print "  (after the handover none will pass [[ -O ]], so the chmod lines go in the sudo plan)"
# endregion: test-first

# region: sudo-plan
# focus: ${(q-)file}
plan=( "sudo chown -R station8:volunteers handover" )
for file in handover/**/*(.); do
  [[ $file == */crew/* ]] && plan+=( "sudo chmod 640 ${(q-)file}" )
done
print "== for the station commander to review and run (not run here):"
print -l -- "  "$^plan
# endregion: sudo-plan
