# Archives and compression · 11 · Medellín gallery unzip

A gallery near Parque Lleras receives `exhibition.zip` with three prints.
`unzip -Z1` lists names only; a `case` picks the Comuna 13 mural; `unzip` extracts
just that member onto the wall.

**What it teaches**

- `unzip -Z1` lists zip members by name only (no date columns that drift)
- `unzip archive member` extracts one file; a `case` picks which print to hang

**Lesson steps**

1. List exhibition.zip members by name only (`unzip -Z1`)
2. Pick the Comuna 13 mural with a case router (`unzip`)
3. Extract only the chosen print onto the wall (`unzip`)

**Files**

| File | Role |
| --- | --- |
| [`select_print.zsh`](select_print.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/14-archives-and-compression/11-medellin-gallery-unzip/select_print.zsh
tests/run-examples.zsh 11-medellin-gallery-unzip
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
