# Searching text with grep · 13 · Auckland youth orchestra, finding parts with Spotlight

The parts librarian for a youth orchestra in Auckland keeps Beethoven and Sibelius parts in a rehearsal folder. `grep -rl` finds Beethoven at once; `mdfind` is Spotlight from the terminal and may still be cold on fresh files; `mdls` reads a file's display name. macOS only.

**What it teaches**

- `mdfind 'query'` is Spotlight from the terminal: it searches file contents and metadata
- `mdfind -onlyin dir` limits the search; `kMDItemDisplayName == "*finlandia*"c` matches names
- Spotlight indexes asynchronously; for a just-written file, `grep -r` is immediate and reliable
- `mdls -name kMDItemDisplayName file` shows metadata; `mdfind`/`mdls` are macOS-only

**Lesson steps**

1. Find Beethoven parts with grep -rl (`grep -rl`)
2. Show the mdfind name query (`mdfind`)
3. Run a Spotlight content query (`mdfind content`)
4. Read the display name with mdls (`mdls`)

**Files**

| File | Role |
| --- | --- |
| [`spotlight_parts.zsh`](spotlight_parts.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/05-searching-text-with-grep/13-auckland-sheet-music/spotlight_parts.zsh
tests/run-examples.zsh 13-auckland-sheet-music
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS (`mdfind` and `mdls`); on Linux it prints a message and exits 2, and the test runner skips it.
