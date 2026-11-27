# Finding files with find and xargs · 12 · Berlin techno label, clearing quarantine from sample packs

A small techno label in Berlin downloads sample packs for its producers, and macOS marks every downloaded file with a `com.apple.quarantine` attribute, so Ableton asks about each sample. The label also tags samples with their BPM in an attribute of its own. macOS `find` can test extended attributes by name, so one pipeline clears the quarantine and keeps the tags. `-xattrname` and `xattr` are macOS-only, so the Linux test job skips this slot.

**What it teaches**

- files downloaded on a Mac carry a `com.apple.quarantine` extended attribute
- macOS `find` can test extended attributes with `-xattrname name` (and `-xattr` for any); GNU `find` has no such tests
- `find ... -xattrname com.apple.quarantine -print0 | xargs -0 xattr -d com.apple.quarantine` removes that one attribute and leaves the label's own tags alone
- `xattr -cr` clears every attribute in a tree, tags included

**Lesson steps**

1. Find the samples macOS still has in quarantine (`find -xattrname`)
2. Find the samples the label tagged with a BPM (`find -xattrname`)
3. Remove only the quarantine attribute through xargs -0 (`xargs -0 xattr -d`)
4. See xattr -cr clear the tags too (`xattr -cr`)

**Files**

| File | Role |
| --- | --- |
| [`unquarantine_samples.zsh`](unquarantine_samples.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/06-find-and-xargs/12-berlin-label-quarantine/unquarantine_samples.zsh
tests/run-examples.zsh 12-berlin-label-quarantine
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS (`find -xattrname` and `xattr`); on Linux it prints a message and exits 2, and the test runner skips it.
