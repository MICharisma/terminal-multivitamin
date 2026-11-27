#!/usr/bin/env zsh
# Archives and compression · 02 · Almaty university course pack
#
# Teaches:
#   - `tar -xzf` extracts a gzipped archive into the current folder
#   - after extract, a plain tree listing shows what the pack delivered
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/kaznu-course.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p staging/syllabus staging/readings staging/labs
print "Week 1–14, Kazakh National University, algorithms" > staging/syllabus/outline.txt
print "Cormen ch. 2: insertion sort notes"                > staging/readings/cormen-ch2.txt
print "Lab 03: heapify a tournament bracket"              > staging/labs/lab-03-heap.txt
tar -czf course-pack.tgz -C staging syllabus readings labs
rm -rf staging

mkdir -p unpacked
cd unpacked

# region: extract-pack
# focus: tar -xzf ../course-pack.tgz
tar -xzf ../course-pack.tgz
print "== extracted course-pack.tgz"
# endregion: extract-pack

# region: show-tree
# focus: ls -1
print "== tree:"
print "labs/$(ls -1 labs)"
print "readings/$(ls -1 readings)"
print "syllabus/$(ls -1 syllabus)"
# endregion: show-tree
