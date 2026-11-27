# Environment and PATH · 09 · Córdoba community radio, one-shot environment on the jingle command

Community radio in Córdoba plays a jingle with a one-shot environment: `STATION=… BED_DB=… ./play_jingle.zsh` sets the variables only for that command. The shell's own values stay put until an explicit `export`.

**What it teaches**

- `NAME=value command` sets the variable only for that command's environment
- the shell's own `NAME` is unchanged afterwards
- several assignments may precede the command: `A=1 B=2 cmd`
- this is the lightest way to hand a config to one helper without `export`/`unset`

**Lesson steps**

1. Prefix the command with assignments (`NAME=value command`)
2. Show the shell values are unchanged (`NAME=value command`)
3. Export the defaults so a bare run sees them (`export`)

**Files**

| File | Role |
| --- | --- |
| [`prefix_env.zsh`](prefix_env.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/11-environment-and-path/09-cordoba-radio-jingle/prefix_env.zsh
tests/run-examples.zsh 09-cordoba-radio-jingle
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
