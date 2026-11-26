# Quoting and parameter expansion · 12 · Brisbane jazz club, announcing the next set

A jazz club in Fortitude Valley, Brisbane, generates a small script that runs `say -o` for each set of the night. Titles hold apostrophes and embedded quotes (`Linh "Bird" Nguyen`); `(q)` makes the script safe to re-run, and escaping fixes the AppleScript one-liner. `say` and `osascript` are macOS tools, so the Linux job skips this one.

**What it teaches**

- `${(q)line}` quotes a value so a generated script can type it back safely
- `${(qq)line}` always wraps in single quotes; use it when the result will be re-parsed
- a double-quoted AppleScript `-e "say \"$line\""` breaks when `$line` holds `"Bird"`; escaping the embedded quotes fixes it
- `say -o file.aiff` writes audio without speaking aloud; `say` is macOS-only

**Lesson steps**

1. Generate a render script with (q) (`${(q)name}`)
2. Show the always-single-quoted form (`${(qq)name}`)
3. Watch AppleScript break on embedded quotes (`osascript -e`)
4. Escape quotes for AppleScript (`${var//"/\"}`)
5. Run the generated script (`zsh render.zsh`)

**Files**

| File | Role |
| --- | --- |
| [`announce_set.zsh`](announce_set.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/04-quoting-and-parameter-expansion/12-brisbane-jazz-set-announce/announce_set.zsh
tests/run-examples.zsh 12-brisbane-jazz-set-announce
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS (`say` and `osascript`); on Linux it prints a message and exits 2, and the test runner skips it.
