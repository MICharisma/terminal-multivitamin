# Editing streams with sed and awk · 08 · Valparaíso funicular logs

After the Concepción funicular maintenance window, tab-separated rider counts list how many passengers each car carried per trip. The operator wants per-car totals, a count of active cars, and the longest car code on the sheet. `BEGIN`/`END`, arrays, and `length` cover each question.

**What it teaches**

- `BEGIN` runs before input; `END` runs after the last line
- awk arrays use `array[key]` with string or numeric keys
- `length(array)` counts elements; `length(string)` counts characters

**Lesson steps**

1. Sum riders per car between BEGIN and END (`awk BEGIN/END`)
2. Count how many array keys exist (`length(array)`)
3. Find the longest string in a column (`length($1)`)

**Files**

| File | Role |
| --- | --- |
| [`funicular_runs.zsh`](funicular_runs.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/car-runs.tsv`](fixtures/car-runs.tsv) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/08-sed-and-awk/08-valparaiso-funicular-logs/funicular_runs.zsh
tests/run-examples.zsh 08-valparaiso-funicular-logs
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
