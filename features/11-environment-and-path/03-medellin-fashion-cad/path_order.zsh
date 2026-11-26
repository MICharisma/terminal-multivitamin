#!/usr/bin/env zsh
# Environment and PATH · 03 · Medellín fashion school, which dxf_plot the CAD lab runs
#
# Teaches:
#   - PATH is searched left to right; the first match wins
#   - put the lab's `bin` in front when a course tool should override the system one
#   - zsh hashes command locations; `hash -r` after changing PATH, or the old path is reused
#   - `whence -p` shows the path that would be used right now
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/upb-moda.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p system/bin lab/bin
print -r -- $'#!/bin/sh\necho system-dxf-plot 1.0\n' > system/bin/dxf_plot
print -r -- $'#!/bin/sh\necho lab-dxf-plot 2026.2\n' > lab/bin/dxf_plot
chmod +x system/bin/dxf_plot lab/bin/dxf_plot

# region: system-first
# focus: PATH=$workdir/system/bin:/usr/bin:/bin
PATH=$workdir/system/bin:/usr/bin:/bin
hash -r
print "== system first: $(dxf_plot)"
print "  whence -p: $(whence -p dxf_plot | sed "s|$workdir|WORK|")"
# endregion: system-first

# region: lab-first
# focus: PATH=$workdir/lab/bin:$PATH
PATH=$workdir/lab/bin:$PATH
hash -r
print "== lab in front: $(dxf_plot)"
print "  whence -p: $(whence -p dxf_plot | sed "s|$workdir|WORK|")"
# endregion: lab-first

# region: stale-hash
# focus: hash -r
PATH=$workdir/system/bin:/usr/bin:/bin
hash dxf_plot=$workdir/lab/bin/dxf_plot
print "== PATH says system, but hash still points at lab: $(dxf_plot)"
hash -r
print "== after hash -r: $(dxf_plot)"
# endregion: stale-hash
