# Navigation and files · 09 · Kraków organ workshop voicing reports

An organ builder's workshop in Kraków restores the pipe organ of a basilica rank by rank, and each voicer writes a report per rank. Before the next site visit, the foreman lists report sizes and which reports are newer than the last full service. `stat` takes different flags on macOS and Linux, so the script detects which one it has; zsh's `zstat` sidesteps the question.

**What it teaches**

- `stat` takes different flags on macOS (BSD: `-f %z`) and Linux (GNU: `-c %s`)
- detecting GNU `stat` once and defining one function for both
- zsh's own `zstat` (the `zsh/stat` module) answers the same question everywhere
- `[[ a -nt b ]]` compares modification times; `[[ -s f ]]` means "not empty"

**Lesson steps**

1. Detect GNU or BSD stat once (`stat --version`)
2. Read every report's size through one function (`stat -c %s / stat -f %z`)
3. Ask zsh's own zstat the same question (`zstat`)
4. List reports newer than the last service, flagging empty ones (`[[ -nt ]]`)

**Files**

| File | Role |
| --- | --- |
| [`voicing_reports.zsh`](voicing_reports.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/01-navigation-and-files/09-krakow-organ-workshop/voicing_reports.zsh
tests/run-examples.zsh 09-krakow-organ-workshop
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
