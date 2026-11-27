# Editing streams with sed and awk · 06 · Bratislava marionette theatre

The Štátna bábková divisko keeps a cast roster as spaced columns and cue notes with pipe delimiters. Posters need puppet and scene; stage managers need the middle cue column. `awk` field numbers, a custom `-F`, and `OFS` with `NF` reshape both files.

**What it teaches**

- `awk '{print $n}'` pulls the nth field from each line
- `awk -F'|' '...'` sets the input field separator
- assigning `OFS` in an action changes the output separator between fields
- built-in `NF` is the field count on the current line

**Lesson steps**

1. Print fields one and three (`awk '{print $n}'`)
2. Split on pipe with `-F` (`awk -F'|'`)
3. Count fields and rejoin with `OFS` (`OFS and NF`)

**Files**

| File | Role |
| --- | --- |
| [`marionette_cast.zsh`](marionette_cast.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/cast-roster.txt`](fixtures/cast-roster.txt) | Fixture copied into the script's temp folder |
| [`fixtures/cue-notes.txt`](fixtures/cue-notes.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/08-sed-and-awk/06-bratislava-marionette-theatre/marionette_cast.zsh
tests/run-examples.zsh 06-bratislava-marionette-theatre
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
