# macOS desktop bridges · 01 · Quito family photo album, revealing a roll in Finder

The Quispe family in Quito keeps carnival phone dumps in dated rolls. Before a Sunday call with cousins in Cuenca, someone on the laptop needs the roll folder and one plaza note opened from Terminal — `open` for Finder/Preview, and a headless guard so CI never pops a window.

**What it teaches**

- `open` hands a folder or file to Finder / Preview without leaving Terminal
- under a headless `TERM` (the test runner), print what would run instead of opening a GUI
- `open` on a folder focuses Finder; on a note it opens the default text app

**Lesson steps**

1. Hand the carnival roll folder to Finder (`open`)
2. Open one plaza note the same way (`open`)
3. Show whether the headless guard is on (`headless guard`)

**Files**

| File | Role |
| --- | --- |
| [`reveal_album.zsh`](reveal_album.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/17-macos-desktop-bridges/01-quito-family-album/reveal_album.zsh
tests/run-examples.zsh 01-quito-family-album
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
