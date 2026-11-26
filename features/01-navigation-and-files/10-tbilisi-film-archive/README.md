# Navigation and files · 10 · Tbilisi film archive, mirroring digitized reels

A film archive in Tbilisi has digitized reels of Pirosmani, Giorgobistve and Repentance and needs a mirror of the scans. The mirror must hold the films themselves, not a nested `scans/` folder, which is exactly where `cp -R src/` differs between macOS and Linux. `diff -r` proves the mirror matches and later shows when it has gone stale; `du -sk` ranks the films by size.

**What it teaches**

- `cp -R src/` behaves differently on macOS (BSD copies the contents) and Linux (GNU copies the folder); `cp -R src/. dest/` means the same on both
- `cp -Rp` keeps modification times, so the mirror sorts like the original
- `diff -r` compares two trees and exits 0 when they match
- `du -sk` totals each film folder in kilobytes for a largest-first list

**Lesson steps**

1. Copy the contents of scans/ the same way on macOS and Linux (`cp -R src/. dest/`)
2. Compare the two trees (`diff -r`)
3. Rank the films by size on disk (`du -sk`)
4. Catch a stale mirror after a change (`diff -r`)

**Files**

| File | Role |
| --- | --- |
| [`mirror_reels.zsh`](mirror_reels.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/01-navigation-and-files/10-tbilisi-film-archive/mirror_reels.zsh
tests/run-examples.zsh 10-tbilisi-film-archive
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
