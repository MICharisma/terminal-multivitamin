# zsh configuration, aliases, and functions · 03 · Cape Town family global aliases

The Naidoo family archive in Cape Town sorts heritage weekend notes. Global aliases (`alias -g`) stand in for a repeated path glob and a `| wc -l` pipe so grandparents' commands stay short.

**What it teaches**

- `alias -g NAME=value` expands `NAME` anywhere in the command line, not only as argv0
- global aliases are handy for repeated redirections and pager tails in a family archive
- quote carefully: a global alias is a sharp tool

**Lesson steps**

1. Define global aliases for a path glob and a pipe (`alias -g`)
2. Use them in the middle of ordinary commands (`alias -g`)

**Files**

| File | Role |
| --- | --- |
| [`global_aliases.zsh`](global_aliases.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/16-zsh-configuration-aliases-and-functions/03-cape-town-global-aliases/global_aliases.zsh
tests/run-examples.zsh 03-cape-town-global-aliases
```

The script creates its own folder with `mktemp -d`, points `ZDOTDIR` at a temp config tree inside it, and deletes everything on exit. It never writes to your real home directory.
