# Permissions and ownership · 12 · Taipei game studio, restoring execute bits after a Windows zip, in bash

An indie studio in Taipei gets the build tools for its game "Night Market Runner" from an outsourcing partner, zipped on Windows. A Windows zip carries no Unix modes, so every script unpacks as 644, including one in a folder with a space in its name. The bash script walks the tree with `find -print0`, reads each file's first line, and restores the execute bit only where it sees `#!`. A last experiment shows why it says `chmod a+x`: plain `chmod +x` quietly follows the umask. It runs on macOS's bash 3.2.

**What it teaches**

- a zip made on Windows carries no Unix modes, so every script unpacks as 644
- `find -print0` with `while IFS= read -r -d ''` survives spaces in file names
- the first line tells you what is a script: `IFS= read -r first_line < "$file"` and `#!`
- `chmod +x` with no "who" letter respects the umask; `chmod a+x` does not
- written for macOS's bash 3.2 too: plain indexed arrays, no `mapfile`, no `declare -A`

**Lesson steps**

1. Count what came out of the zip executable (`find -perm -0100`)
2. Walk every file safely, spaces and all (`find -print0`)
3. Treat files that start with #! as scripts (`#! line`)
4. Give every script its execute bit back (`chmod a+x`)
5. Test before running the release build (`[[ -x ]]`)
6. See chmod +x follow the umask (`chmod +x`)

**Files**

| File | Role |
| --- | --- |
| [`restore_exec_bits.sh`](restore_exec_bits.sh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/09-permissions-and-ownership/12-taipei-game-build-tools/restore_exec_bits.sh
tests/run-examples.zsh 12-taipei-game-build-tools
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
