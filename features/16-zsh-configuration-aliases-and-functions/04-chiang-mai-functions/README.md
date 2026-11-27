# zsh configuration, aliases, and functions · 04 · Chiang Mai lacquer workshop functions

A lacquer workshop near Chiang Mai's old city tracks trays from raw to sealed. A `function` with a local argument moves one tray; `typeset -f` prints the definition for the apprentice whiteboard.

**What it teaches**

- `function name { ... }` (or `name()`) defines a function with its own arguments
- `typeset -f name` prints the definition, useful when teaching apprentices
- functions beat aliases when you need arguments, locals, or more than one command

**Lesson steps**

1. Define a seal_tray function with a local argument (`function`)
2. Print the definition for the apprentice handout (`typeset -f`)
3. Call the function to move a tray (`function`)

**Files**

| File | Role |
| --- | --- |
| [`workshop_functions.zsh`](workshop_functions.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/16-zsh-configuration-aliases-and-functions/04-chiang-mai-functions/workshop_functions.zsh
tests/run-examples.zsh 04-chiang-mai-functions
```

The script creates its own folder with `mktemp -d`, points `ZDOTDIR` at a temp config tree inside it, and deletes everything on exit. It never writes to your real home directory.
