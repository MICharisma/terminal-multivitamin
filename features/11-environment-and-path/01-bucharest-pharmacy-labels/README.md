# Environment and PATH · 01 · Bucharest pharmacy, exporting the batch number for every label printer

A pharmacy in Bucharest prints drug labels from a helper script. A plain `BATCH_NO=…` stays in the shell; only `export` puts it in the environment the printer inherits. `export -p` shows the flag, and `unset` clears both the shell variable and the environment entry.

**What it teaches**

- a plain assignment is local to the shell; `export` puts it in the environment children inherit
- `printenv NAME` reads the environment; `print $NAME` reads the shell variable (usually the same)
- `export -p` lists export flags; `unset` removes both the shell variable and the environment entry
- a child started without the export does not see the value

**Lesson steps**

1. Assign a batch number without exporting it (`assignment`)
2. Export it so children inherit it (`export`)
3. List the export with export -p (`export -p`)
4. Unset it from the shell and the environment (`unset`)

**Files**

| File | Role |
| --- | --- |
| [`label_batch.zsh`](label_batch.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/11-environment-and-path/01-bucharest-pharmacy-labels/label_batch.zsh
tests/run-examples.zsh 01-bucharest-pharmacy-labels
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
