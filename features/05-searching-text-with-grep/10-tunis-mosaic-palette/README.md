# Searching text with grep · 10 · Tunis mosaic workshop, searching only the palette files

A mosaic workshop in the Medina of Tunis keeps a folder per panel, each with notes and a palette CSV. GNU grep's `--include` and `--exclude` limit a recursive search; BSD grep needs `find -exec` instead, so the script detects the flavour once.

**What it teaches**

- GNU `grep --include='*.csv'` limits a recursive search to matching file names
- `--exclude='*.md'` skips matching names; `--exclude-dir=` skips whole folders
- BSD grep (macOS) has no `--include`; detect GNU once, or fall back to `find … -exec grep`
- the portable form shown here keeps the lesson working on both flavours

**Lesson steps**

1. Detect GNU vs BSD grep (`grep --help`)
2. Search only *.csv with --include (`grep --include`)
3. Skip *.md with --exclude (`grep --exclude`)
4. Use the portable find -exec form (`find -exec grep`)

**Files**

| File | Role |
| --- | --- |
| [`palette_search.zsh`](palette_search.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/panel-a/notes.md`](fixtures/panel-a/notes.md) | Fixture copied into the script's temp folder |
| [`fixtures/panel-a/palette.csv`](fixtures/panel-a/palette.csv) | Fixture copied into the script's temp folder |
| [`fixtures/panel-b/notes.md`](fixtures/panel-b/notes.md) | Fixture copied into the script's temp folder |
| [`fixtures/panel-b/palette.csv`](fixtures/panel-b/palette.csv) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/05-searching-text-with-grep/10-tunis-mosaic-palette/palette_search.zsh
tests/run-examples.zsh 10-tunis-mosaic-palette
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
