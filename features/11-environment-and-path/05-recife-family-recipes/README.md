# Environment and PATH · 05 · Recife family kitchen, marking the recipe year for every helper script

The Oliveira family kitchen in Recife marks the recipe year for every helper with `typeset -x`, locks it with `typeset -r`, and later removes the export bit with `typeset +x` while keeping the shell value.

**What it teaches**

- `typeset -x NAME=value` is the same as `export` and can combine flags
- `typeset -r` makes a variable readonly; a later assignment fails
- `typeset +x NAME` removes the export bit but keeps the shell value
- `typeset -p NAME` shows the flags currently attached

**Lesson steps**

1. Export with typeset -x (`typeset -x`)
2. Lock the year with typeset -r (`typeset -r`)
3. Remove the export bit with typeset +x (`typeset +x`)

**Files**

| File | Role |
| --- | --- |
| [`export_flags.zsh`](export_flags.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/11-environment-and-path/05-recife-family-recipes/export_flags.zsh
tests/run-examples.zsh 05-recife-family-recipes
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
