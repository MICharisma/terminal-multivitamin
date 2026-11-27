# zsh configuration, aliases, and functions · 13 · Ulaanbaatar library modular zshrc

The National Library of Mongolia IT desk in Ulaanbaatar ships a modular `ZDOTDIR` tree: fragments for named stack directories (`hash -d`), aliases, and a `bindkey` shortcut. Everything loads under a temp ZDOTDIR — never the librarian's real home.

**What it teaches**

- a modular `.zshrc` `source`s small fragments for aliases, dirs, and keys
- `hash -d` / named directories give short `cd ~catalog` jumps for the stacks
- `bindkey` wires a widget in the temp ZDOTDIR without touching your keymap

**Lesson steps**

1. Write sourced fragments for dirs, aliases, and keys (`source`)
2. Resolve named directories from hash -d (`hash -d`)
3. Confirm bindkey and the stacks alias (`bindkey`)

**Files**

| File | Role |
| --- | --- |
| [`modular_zshrc.zsh`](modular_zshrc.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/16-zsh-configuration-aliases-and-functions/13-ulaanbaatar-library-modular/modular_zshrc.zsh
tests/run-examples.zsh 13-ulaanbaatar-library-modular
```

The script creates its own folder with `mktemp -d`, points `ZDOTDIR` at a temp config tree inside it, and deletes everything on exit. It never writes to your real home directory.
