# Environment and PATH · 03 · Medellín fashion school, which dxf_plot the CAD lab runs

A fashion school in Medellín has a lab `dxf_plot` that should override the system one. PATH is searched left to right, `whence -p` shows the winner, and a planted hash entry proves why you run `hash -r` after changing PATH.

**What it teaches**

- PATH is searched left to right; the first match wins
- put the lab's `bin` in front when a course tool should override the system one
- zsh hashes command locations; `hash -r` after changing PATH, or the old path is reused
- `whence -p` shows the path that would be used right now

**Lesson steps**

1. Search PATH with the system bin first (`PATH`)
2. Prepend the lab bin so it wins (`PATH`)
3. Plant a stale hash entry and clear it (`hash -r`)

**Files**

| File | Role |
| --- | --- |
| [`path_order.zsh`](path_order.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/11-environment-and-path/03-medellin-fashion-cad/path_order.zsh
tests/run-examples.zsh 03-medellin-fashion-cad
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
