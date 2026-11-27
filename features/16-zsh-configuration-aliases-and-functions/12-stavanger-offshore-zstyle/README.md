# zsh configuration, aliases, and functions · 12 · Stavanger offshore zstyle

An offshore logistics desk in Stavanger shares one completion matcher and git `vcs_info` formats across laptops. `zstyle` stores them; `-g` and `-L` read them back for the onboarding sheet.

**What it teaches**

- `zstyle ':context:' key value` stores settings for completion and other modules
- `zstyle -g` reads a value back; `zstyle -L` lists them as re-runnable commands
- offshore desks pin completion matcher and vcs_info formats without editing functions

**Lesson steps**

1. Set completion and vcs_info zstyles for the desk (`zstyle`)
2. Read the matcher back with zstyle -g (`zstyle`)
3. List them as re-runnable zstyle lines (`zstyle`)

**Files**

| File | Role |
| --- | --- |
| [`zstyle_desk.zsh`](zstyle_desk.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/16-zsh-configuration-aliases-and-functions/12-stavanger-offshore-zstyle/zstyle_desk.zsh
tests/run-examples.zsh 12-stavanger-offshore-zstyle
```

The script creates its own folder with `mktemp -d`, points `ZDOTDIR` at a temp config tree inside it, and deletes everything on exit. It never writes to your real home directory.
