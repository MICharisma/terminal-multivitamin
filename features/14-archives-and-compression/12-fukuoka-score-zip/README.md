# Archives and compression · 12 · Fukuoka score zip

A conservatory librarian in Hakata packs shamisen and koto scores for a student
who opens them on a Mac. `ditto -c -k` builds a Finder-friendly zip; `ditto -x -k`
extracts it back.

**What it teaches**

- `ditto -c -k` builds a Finder-friendly zip from a folder tree
- `ditto -x -k` extracts that zip back; Terminal listing confirms the scores

**Lesson steps**

1. Zip the repertoire folder with ditto for Finder (`ditto -c -k`)
2. Extract the zip with ditto and list the scores (`ditto -x -k`)

**Files**

| File | Role |
| --- | --- |
| [`ditto_scores.zsh`](ditto_scores.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`); created on macOS |

**Try it**

From the repository root (macOS):

```sh
features/14-archives-and-compression/12-fukuoka-score-zip/ditto_scores.zsh
tests/run-examples.zsh 12-fukuoka-score-zip
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It is macOS-only (`# requires: macos`); Linux runners skip it.
