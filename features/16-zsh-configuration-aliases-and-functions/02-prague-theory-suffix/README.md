# zsh configuration, aliases, and functions · 02 · Prague theory-lab suffix aliases

A music-theory lab at HAMU in Prague keeps counterpoint worksheets as `.pdf` and `.ly` files. `alias -s` makes typing the filename open the right tool — demonstrated here with print stand-ins.

**What it teaches**

- `alias -s ext=command` runs `command file.ext` when you type `file.ext` alone
- suffix aliases are per-extension shortcuts for opening lab worksheets
- the demo invokes the alias by executing the filename as a command word

**Lesson steps**

1. Define suffix aliases for pdf and ly worksheets (`alias -s`)
2. Invoke a worksheet by typing its filename (`alias -s`)

**Files**

| File | Role |
| --- | --- |
| [`suffix_scores.zsh`](suffix_scores.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/16-zsh-configuration-aliases-and-functions/02-prague-theory-suffix/suffix_scores.zsh
tests/run-examples.zsh 02-prague-theory-suffix
```

The script creates its own folder with `mktemp -d`, points `ZDOTDIR` at a temp config tree inside it, and deletes everything on exit. It never writes to your real home directory.
