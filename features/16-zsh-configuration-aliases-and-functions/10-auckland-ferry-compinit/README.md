# zsh configuration, aliases, and functions · 10 · Auckland ferry completions

Auckland Transport ferry ops keep a tiny `schedule` helper for Devonport runs. A `_schedule` completer on `fpath` plus `compinit -d` (dump in the temp folder) wires tab completion without touching `~/.zcompdump`.

**What it teaches**

- `compinit` loads zsh's completion system from directories on `fpath`
- a custom completion function named `_command` lives in a directory on `fpath`
- after `compinit`, `whence -v _schedule` shows the completion helper is available

**Lesson steps**

1. Put the ferry completion directory on fpath (`fpath`)
2. Load the completion system with compinit (`compinit`)
3. Verify _schedule is available (`compinit`)

**Files**

| File | Role |
| --- | --- |
| [`ferry_completions.zsh`](ferry_completions.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/16-zsh-configuration-aliases-and-functions/10-auckland-ferry-compinit/ferry_completions.zsh
tests/run-examples.zsh 10-auckland-ferry-compinit
```

The script creates its own folder with `mktemp -d`, points `ZDOTDIR` at a temp config tree inside it, and deletes everything on exit. It never writes to your real home directory.
