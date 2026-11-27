# zsh configuration, aliases, and functions · 05 · Vienna chamber orchestra autoload

A chamber orchestra in Vienna keeps rehearsal helpers as one function per file under `zfunctions/`. `fpath` points there; `autoload -Uz cue_letter` loads it on first call during rehearsal.

**What it teaches**

- `fpath` is the list of directories where `autoload` looks for function files
- `autoload -Uz name` marks `name` to load from `$fpath` on first call
- one file per function keeps the orchestra's cue helpers modular

**Lesson steps**

1. Add the orchestra's zfunctions directory to fpath (`fpath`)
2. Mark cue_letter for autoload (`autoload -Uz`)
3. Call it so zsh loads the file on first use (`autoload -Uz`)

**Files**

| File | Role |
| --- | --- |
| [`autoload_cues.zsh`](autoload_cues.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/16-zsh-configuration-aliases-and-functions/05-vienna-orchestra-autoload/autoload_cues.zsh
tests/run-examples.zsh 05-vienna-orchestra-autoload
```

The script creates its own folder with `mktemp -d`, points `ZDOTDIR` at a temp config tree inside it, and deletes everything on exit. It never writes to your real home directory.
