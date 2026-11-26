#!/bin/sh
# Permissions and ownership · 11 · Gdańsk shipyard welding cell, installing robot tools in portable sh
#
# Teaches:
#   - `install -m 0755 src dest` copies and sets the mode in one step: no moment where a
#     config file sits on disk with the wrong mode, as it would between `cp` and `chmod`
#   - `install -d -m 0750 dir` creates a folder with an exact mode, whatever the umask
#   - `cp` keeps the source's mode (minus the umask), so a 600 secret copied with `cp` stays 600,
#     but a 644 draft stays 644 where 640 was wanted
#   - a here-doc manifest read with `while read -r mode kind src dest` keeps the plan in one place
#   - `ls -ld path | cut -c1-10` reads a mode string the same way on macOS and Linux
set -eu

workdir=$(mktemp -d "${TMPDIR:-/tmp}/stocznia-spawanie.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir source
printf '#!/bin/sh\necho "cell 3: torch TCP offset recalibrated, 0.2 mm"\n' > source/calibrate_torch.sh
printf '#!/bin/sh\necho "cell 3: wire feed 9.5 m/min, argon 18 l/min"\n' > source/check_wire_feed.sh
printf 'robot=KR-16 cell=3 hull_block=B-214\n' > source/cell3.conf
printf 'fanuc_service_pin=4417\n' > source/service.secret
chmod 600 source/service.secret

mode_of() { ls -ld -- "$1" | cut -c1-10; }

# region: manifest
# focus: while read -r mode kind src dest
while read -r mode kind src dest; do
  case $kind in
    dir)  install -d -m "$mode" "$dest" ;;
    file) install -m "$mode" "source/$src" "$dest" ;;
  esac
done <<'MANIFEST'
0755 dir  -                   opt/spawanie
0755 dir  -                   opt/spawanie/bin
0750 dir  -                   opt/spawanie/etc
0700 dir  -                   opt/spawanie/private
0755 file calibrate_torch.sh  opt/spawanie/bin/calibrate_torch
0755 file check_wire_feed.sh  opt/spawanie/bin/check_wire_feed
0640 file cell3.conf          opt/spawanie/etc/cell3.conf
0600 file service.secret      opt/spawanie/private/service.secret
MANIFEST
# endregion: manifest

# region: verify
# focus: mode_of "$path"
echo "== installed:"
for path in opt/spawanie opt/spawanie/bin opt/spawanie/bin/* opt/spawanie/etc \
            opt/spawanie/etc/cell3.conf opt/spawanie/private opt/spawanie/private/service.secret; do
  echo "  $(mode_of "$path") $path"
done
# endregion: verify

# region: run-installed
# focus: opt/spawanie/bin/calibrate_torch
echo "== the installed tools run straight away:"
opt/spawanie/bin/calibrate_torch
opt/spawanie/bin/check_wire_feed
# endregion: run-installed

# region: cp-compared
# focus: cp source/cell3.conf with-cp.conf
cp source/cell3.conf with-cp.conf
cp source/service.secret with-cp.secret
echo "== the same files copied with cp keep their source modes:"
echo "  $(mode_of with-cp.conf) with-cp.conf  (wanted 640)"
echo "  $(mode_of with-cp.secret) with-cp.secret"
# endregion: cp-compared
