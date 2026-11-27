# Environment and PATH · 12 · Penang fab lab, PATH and hashing in bash

A fab lab in Penang switches between laser and CNC `gcode_send` tools in bash. After the first run the command is hashed; `hash -p` plants a stale entry, and `hash -r` clears it so PATH wins again. Works on macOS's bash 3.2.

**What it teaches**

- bash has no tied `path` array: edit `PATH` as a string, then `hash -r`
- `hash` shows the cached locations; `hash -r` clears them after a PATH change
- `type -a` lists every match; `command -v` stays the portable one-liner
- works on macOS's bash 3.2 as well as newer bash

**Lesson steps**

1. Point PATH at the laser tools (`PATH`)
2. See gcode_send land in the hash table (`hash`)
3. Plant a stale hash entry and clear it (`hash -p`)
4. List every match with type -a (`type -a`)

**Files**

| File | Role |
| --- | --- |
| [`bash_path.sh`](bash_path.sh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/11-environment-and-path/12-penang-fab-lab/bash_path.sh
tests/run-examples.zsh 12-penang-fab-lab
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
