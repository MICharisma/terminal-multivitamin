# Environment and PATH · 02 · Colombo tea tasting room, scoring cups in a clean environment

A tea tasting room in Colombo scores cups with a small helper that prints its environment. The desk laptop has a surprising `LANG`; `env -i` starts the scorer with only the `HOME` and `PATH` it needs, and `env` still lists `CUPPING_NOTE` in the parent shell.

**What it teaches**

- `env -i` starts a command with an empty environment; only what you pass is there
- pass `HOME`, `PATH`, and anything else the child needs explicitly after `-i`
- without `-i`, a child inherits everything, including a surprising `LANG` from the desk laptop
- `env` alone lists the current environment; useful before you wipe it

**Lesson steps**

1. See what an ordinary run inherits (`env`)
2. Start the scorer with env -i (`env -i`)
3. Confirm CUPPING_NOTE is still in this shell (`env`)

**Files**

| File | Role |
| --- | --- |
| [`clean_cupping.zsh`](clean_cupping.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/score_cup.sh`](fixtures/score_cup.sh) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/11-environment-and-path/02-colombo-tea-tasting/clean_cupping.zsh
tests/run-examples.zsh 02-colombo-tea-tasting
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
