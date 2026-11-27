#!/usr/bin/env zsh
# Finding files with find and xargs · 13 · Shenzhen electronics factory, firmware release manifest
#
# Teaches:
#   - `-regex` matches the whole path, not just the name, so patterns start with `.*/`
#   - extended regexes need `find -E dir` on BSD and `find dir -regextype posix-extended` on GNU:
#     one flag goes before the paths, the other after, so the script keeps them in two arrays
#   - one function combines `-prune`, `-type f`, `-regex`, and `-newer` with `-print0`
#   - `xargs -0 cksum` turns the result into a manifest; a zsh associative array keyed by CRC
#     spots board revisions that got byte-identical images
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/baoan-firmware.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

image() {
  mkdir -p firmware/${1:h}
  print "$2" > firmware/$1
  touch -t $3 firmware/$1
}
image ebike-ctrl/fw-v2.4.0-rev-a.bin          "motor controller 2.4.0"        202610150900
image ebike-ctrl/fw-v2.4.1-rev-a.bin          "motor controller 2.4.1"        202611201400
image ebike-ctrl/fw-v2.4.1-rev-b.bin          "motor controller 2.4.1"        202611201405
image ebike-ctrl/fw-v2.4.1-rev-a.bin.map      "linker map for 2.4.1"          202611201400
image ebike-ctrl/fw-v2.4.1-rc1-rev-a.bin      "motor controller 2.4.1 rc1"    202611180900
image ebike-ctrl/build/fw-v2.4.1-rev-a.bin    "intermediate link output"      202611201359
image battery-bms/fw-v1.9.3-rev-c.bin         "battery management 1.9.3"      202609300900
image battery-bms/fw-v1.10.0-rev-c.bin        "battery management 1.10.0"     202611211000
image battery-bms/.cache/fw-v1.10.0-rev-c.bin "cached object"                 202611211000
print "v2.4.0 / v1.9.3 shipped to the assembly line" > last-release.stamp
touch -t 202611010000 last-release.stamp

# region: regex-flavor
# focus: before_paths=( -E )
before_paths=() after_paths=()
if find --version >/dev/null 2>&1; then
  after_paths=( -regextype posix-extended )
else
  before_paths=( -E )
fi
# endregion: regex-flavor

# region: find-images
# focus: -regex '.*/fw-v[0-9]+\.[0-9]+\.[0-9]+-rev-[a-c]\.bin'
release_images() {
  find $before_paths firmware $after_paths \
    \( -name build -o -name .cache \) -prune -o \
    -type f -regex '.*/fw-v[0-9]+\.[0-9]+\.[0-9]+-rev-[a-c]\.bin' \
    -newer last-release.stamp -print0
}
print "== images for this release (no rc builds, maps, build or cache copies):"
release_images | tr '\0' '\n' | sort
# endregion: find-images

# region: manifest
# focus: release_images | xargs -0 cksum | sort -k 3
release_images | xargs -0 cksum | sort -k 3 > MANIFEST.txt
print "== MANIFEST.txt, crc, bytes, path:"
cat MANIFEST.txt
# endregion: manifest

# region: identical-images
# focus: images_by_crc[$crc]+=" ${image:t}"
typeset -A images_by_crc
while read -r crc bytes image; do
  images_by_crc[$crc]+=" ${image:t}"
done < MANIFEST.txt
for crc names in ${(kv)images_by_crc}; do
  shared=( ${=names} )
  if (( $#shared > 1 )); then
    print "byte-identical, one image can serve both boards:$names"
  fi
done
# endregion: identical-images
