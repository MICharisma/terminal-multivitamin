#!/usr/bin/env bash
# Permissions and ownership · 12 · Taipei game studio, restoring execute bits after a Windows zip, in bash
#
# Teaches:
#   - a zip made on Windows carries no Unix modes, so every script unpacks as 644
#   - `find -print0` with `while IFS= read -r -d ''` survives spaces in file names
#   - the first line tells you what is a script: `IFS= read -r first_line < "$file"` and `#!`
#   - `chmod +x` with no "who" letter respects the umask; `chmod a+x` does not
#   - written for macOS's bash 3.2 too: plain indexed arrays, no `mapfile`, no `declare -A`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/yeshi-build.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

umask 022
mkdir -p night-market-runner/{tools,"build scripts",assets/sprites}
printf '#!/bin/sh\necho "packing sprite atlas: 412 frames"\n' > night-market-runner/tools/pack_atlas
printf '#!/usr/bin/env python3\nprint("exporting 18 levels to Switch format")\n' > night-market-runner/tools/export_levels.py
printf '#!/bin/bash\necho "build 2026.11.26-rc2 for Steam and Switch"\n' > "night-market-runner/build scripts/release build.sh"
printf 'PNG placeholder: stinky tofu stall, 64x64\n' > night-market-runner/assets/sprites/stall_tofu.png
printf 'cd "build scripts" && ./"release build.sh"\n' > night-market-runner/README.txt

# region: what-unzip-gave
# focus: find night-market-runner -type f -perm -0100
echo "== executable after unzip: $(find night-market-runner -type f -perm -0100 | wc -l | tr -d ' ') files"
# endregion: what-unzip-gave

# region: find-scripts
# focus: while IFS= read -r -d '' file
scripts=()
while IFS= read -r -d '' file; do
  IFS= read -r first_line < "$file" || true
  if [[ $first_line == '#!'* ]]; then
    scripts+=( "$file" )
  fi
done < <(find night-market-runner -type f -print0)
# endregion: find-scripts

# region: restore-bits
# focus: chmod a+x -- "${scripts[@]}"
chmod a+x -- "${scripts[@]}"
echo "== restored the x bit on ${#scripts[@]} scripts:"
for script in "${scripts[@]}"; do
  echo "  $(ls -l -- "$script" | cut -c1-10) ${script#night-market-runner/}"
done | sort -k2
echo "  $(ls -l -- night-market-runner/assets/sprites/stall_tofu.png | cut -c1-10) assets/sprites/stall_tofu.png (no #!, left alone)"
# endregion: restore-bits

# region: run-script
# focus: [[ -x "$release" ]]
release="night-market-runner/build scripts/release build.sh"
[[ -x "$release" ]] && "./$release"
# endregion: run-script

# region: umask-gotcha
# focus: chmod +x pack_atlas_copy
cp night-market-runner/tools/pack_atlas pack_atlas_copy
chmod a-x pack_atlas_copy
(
  umask 077
  chmod +x pack_atlas_copy
  echo "== with umask 077, chmod +x gives $(ls -l pack_atlas_copy | cut -c1-10)"
  chmod a+x pack_atlas_copy
  echo "   and chmod a+x gives     $(ls -l pack_atlas_copy | cut -c1-10)"
)
# endregion: umask-gotcha
