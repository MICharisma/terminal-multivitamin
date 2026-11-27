# Navigation and files · 05 · Oaxaca recording studio, picking the latest takes

At the end of a night recording sones istmeños in an Oaxaca studio, the band wants to hear the last three takes. The engineer stamps each take with the time it was recorded, lets `ls -t` sort by time, and gives a new mix the same timestamp as the take it came from, so it sorts beside its source.

**What it teaches**

- `touch -t CCYYMMDDhhmm` stamps a file with a chosen time (BSD and GNU alike)
- `ls -t` sorts newest first; `ls -tr` puts the oldest first
- `touch -r` copies one file's timestamp onto another
- an associative array keeps each take next to the time it was recorded

**Lesson steps**

1. Stamp each take with the time it was recorded (`touch -t`)
2. List the newest takes first (`ls -t`)
3. Find the first take of the night (`ls -tr`)
4. Give a mix its source take's timestamp (`touch -r`)

**Files**

| File | Role |
| --- | --- |
| [`latest_takes.zsh`](latest_takes.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/01-navigation-and-files/05-oaxaca-studio-takes/latest_takes.zsh
tests/run-examples.zsh 05-oaxaca-studio-takes
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
