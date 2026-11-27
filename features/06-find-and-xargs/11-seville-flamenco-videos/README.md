# Finding files with find and xargs · 11 · Seville flamenco academy, collecting rehearsal videos, in bash

A flamenco academy in Triana, Seville, films every pupil's rehearsals, one folder per pupil, and picks clips for the end-of-term festival reel. Pupils' folders are their full names, spaces included, and two of them rehearsed alegrías. This slot is in bash because bash runs the right-hand side of a pipe in a subshell, which loses the loop's counter, and process substitution is the fix. It runs on macOS's bash 3.2.

**What it teaches**

- in bash, `find ... | while read` runs the loop in a subshell, so a counter set inside it is lost
- `while IFS= read -r -d '' video; do ...; done < <(find ... -print0)` keeps the loop in the current shell and reads NUL-separated names safely
- `videos+=("$video")` builds an array that works in macOS's bash 3.2, which has no `mapfile -d`
- `${rel//\//__}` flattens a path into one file name, so two pupils' `alegrias.mov` don't collide

**Lesson steps**

1. Count videos through a pipe and lose the count (`find | while read`)
2. Read NUL-separated names in the current shell (`while IFS= read -r -d ''`)
3. Collect the names into a bash 3.2 array (`array+=("$item")`)
4. Flatten each path into a unique file name for the reel (`${var//pattern/replacement}`)

**Files**

| File | Role |
| --- | --- |
| [`collect_videos.sh`](collect_videos.sh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/06-find-and-xargs/11-seville-flamenco-videos/collect_videos.sh
tests/run-examples.zsh 11-seville-flamenco-videos
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux, including macOS's bash 3.2.
