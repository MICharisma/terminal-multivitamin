#!/usr/bin/env zsh
# Finding files with find and xargs · 04 · Lagos film editing suite, clearing the render cache
#
# Teaches:
#   - `-size +300k` means "more than 300 KiB" in both BSD and GNU `find`; a `c` suffix counts bytes
#   - `-empty` matches zero-byte files and folders with nothing in them
#   - run the expression with `-print` first, and swap in `-delete` once the list looks right
#   - `-delete` works depth-first, so `-type d -empty -delete` clears nested empty folders in one pass
#   - `find` reads its expression left to right: `-delete` before `-name` deletes everything it reaches
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/surulere-edit.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

film=owambe-nights
mkdir -p $film/{cache/render/scene-09,cache/render/scene-11/frames,cache/peaks,proxies,exports}
make_file() { head -c $(( $2 * 1024 )) /dev/zero > $film/$1 }
make_file cache/render/scene-04_take-2.cache 800
make_file cache/render/scene-07_take-1.cache 400
make_file cache/render/scene-07_take-1.xml 2
make_file proxies/scene-04_proxy.mov 600
make_file exports/owambe-nights_rough-cut.mp4 900
: > $film/cache/peaks/dialogue-scene-04.pkf

# region: big-files
# focus: -size +300k
print "== everything over 300 KiB, keepers included:"
find $film -type f -size +300k | sort
# endregion: big-files

# region: dry-run
# focus: \( -size +300k -o -empty \) -print
print "== dry run in the cache: big renders and the empty peak file from the crash:"
find $film/cache -type f \( -size +300k -o -empty \) -print | sort
# endregion: dry-run

# region: delete
# focus: \( -size +300k -o -empty \) -delete
find $film/cache -type f \( -size +300k -o -empty \) -delete
print "files left in the cache: $(find $film/cache -type f | sed "s|^$film/||")"
# endregion: delete

# region: empty-folders
# focus: find $film -type d -empty -delete
print "== empty right now; the dry run cannot know scene-11 will empty out too:"
find $film -type d -empty -print | sort
find $film -type d -empty -delete
print "== folders left:"
find $film -type d | sort
# endregion: empty-folders

# region: delete-first
# focus: find rehearsal-copy -delete -name '*.xml'
cp -R $film rehearsal-copy
find rehearsal-copy -delete -name '*.xml'
if [[ ! -e rehearsal-copy ]]; then
  print "with -delete first, find removed the whole rehearsal-copy, not just the .xml"
fi
# endregion: delete-first
