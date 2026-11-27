# zsh configuration, aliases, and functions · 01 · Bogotá agency shell aliases

A creative desk at an agency in Bogotá keeps short aliases for campaign folders. The script defines them, lists them with `alias -L`, and retires `shoot` after the location wrap — all inside a temp shell, never your real rc files.

**What it teaches**

- `alias name=value` defines a shortcut expanded when `name` is a command word
- `alias -L` lists aliases as re-runnable `alias` statements
- `unalias` removes one when a campaign codename retires

**Lesson steps**

1. Define campaign aliases for the desk (`alias`)
2. List them as re-runnable alias statements (`alias -L`)
3. Retire a finished campaign alias (`unalias`)

**Files**

| File | Role |
| --- | --- |
| [`agency_aliases.zsh`](agency_aliases.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/16-zsh-configuration-aliases-and-functions/01-bogota-agency-aliases/agency_aliases.zsh
tests/run-examples.zsh 01-bogota-agency-aliases
```

The script creates its own folder with `mktemp -d`, points `ZDOTDIR` at a temp config tree inside it, and deletes everything on exit. It never writes to your real home directory.
