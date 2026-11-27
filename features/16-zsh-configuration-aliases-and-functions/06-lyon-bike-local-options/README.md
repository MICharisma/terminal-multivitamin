# zsh configuration, aliases, and functions · 06 · Lyon bicycle cooperative local options

La Ruche Vélo in Lyon lists spare-part files that may not exist yet. A function uses `emulate -L zsh` and `setopt local_options null_glob` so a missing glob is empty inside, while the caller's `nomatch` stays on.

**What it teaches**

- `emulate -L zsh` resets options to a known zsh baseline inside a function
- `setopt local_options` makes later `setopt`/`unsetopt` revert when the function returns
- the cooperative's null_glob stays local so the caller's options are unchanged

**Lesson steps**

1. Scope null_glob with emulate -L and local_options (`setopt local_options`)
2. Show the caller's nomatch is unchanged (`emulate -L zsh`)

**Files**

| File | Role |
| --- | --- |
| [`local_options.zsh`](local_options.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/16-zsh-configuration-aliases-and-functions/06-lyon-bike-local-options/local_options.zsh
tests/run-examples.zsh 06-lyon-bike-local-options
```

The script creates its own folder with `mktemp -d`, points `ZDOTDIR` at a temp config tree inside it, and deletes everything on exit. It never writes to your real home directory.
