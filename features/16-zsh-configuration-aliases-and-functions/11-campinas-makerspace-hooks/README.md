# zsh configuration, aliases, and functions · 11 · Campinas makerspace hooks

A makerspace in Campinas stamps which project folder you are in after every `cd`. An anonymous function records opening the space; `add-zsh-hook chpwd` appends each move to a visit log.

**What it teaches**

- an anonymous function `() { ... }` runs once without leaving a named function
- `add-zsh-hook chpwd fn` registers `fn` to run after every directory change
- the makerspace uses a chpwd hook to stamp the current project folder

**Lesson steps**

1. Run one-shot setup in an anonymous function (`()`)
2. Register a chpwd hook with add-zsh-hook (`add-zsh-hook`)
3. Walk project folders and read the visit log (`add-zsh-hook`)

**Files**

| File | Role |
| --- | --- |
| [`precwd_hook.zsh`](precwd_hook.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/16-zsh-configuration-aliases-and-functions/11-campinas-makerspace-hooks/precwd_hook.zsh
tests/run-examples.zsh 11-campinas-makerspace-hooks
```

The script creates its own folder with `mktemp -d`, points `ZDOTDIR` at a temp config tree inside it, and deletes everything on exit. It never writes to your real home directory.
