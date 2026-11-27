# zsh configuration, aliases, and functions · 09 · Sarajevo radio prompt

Community radio eR in Sarajevo wants every shell in Studio B to show the room and an ON AIR flag. `PROMPT` and `RPROMPT` carry that; `print -P` previews the escapes without drawing a real prompt.

**What it teaches**

- `PROMPT` is the left prompt string, expanded with prompt escapes each time it prints
- `RPROMPT` sits on the right edge for glanceable status (studio, on-air flag)
- `print -P` expands prompt escapes without waiting for a real prompt draw

**Lesson steps**

1. Build the left PROMPT with studio and path (`PROMPT`)
2. Set RPROMPT to the on-air flag (`RPROMPT`)
3. Preview both with print -P (`PROMPT`)

**Files**

| File | Role |
| --- | --- |
| [`on_air_prompt.zsh`](on_air_prompt.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/16-zsh-configuration-aliases-and-functions/09-sarajevo-radio-prompt/on_air_prompt.zsh
tests/run-examples.zsh 09-sarajevo-radio-prompt
```

The script creates its own folder with `mktemp -d`, points `ZDOTDIR` at a temp config tree inside it, and deletes everything on exit. It never writes to your real home directory.
