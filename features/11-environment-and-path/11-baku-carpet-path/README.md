# Environment and PATH · 11 · Baku carpet workshop, editing PATH in portable sh

A carpet workshop in Baku edits PATH from portable `sh`: prepend the workshop bin, restore a saved `DEFAULT_PATH`, and locate tools with `command -v`. There is no tied `path` array here.

**What it teaches**

- POSIX `sh` has no `$path` array: prepend with `PATH="$dir:$PATH"` and export it
- `command -v name` is the portable locator; `type` and `which` are not reliable in sh
- `unset PATH` is a bad idea: the shell may fall back to a default, or find nothing
- keep a `DEFAULT_PATH` and rebuild from it when a temporary prepend should end

**Lesson steps**

1. Prepend the workshop bin to PATH (`PATH=dir:$PATH`)
2. Restore the saved DEFAULT_PATH (`PATH`)
3. Locate tools with command -v (`command -v`)

**Files**

| File | Role |
| --- | --- |
| [`path_sh.sh`](path_sh.sh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/11-environment-and-path/11-baku-carpet-path/path_sh.sh
tests/run-examples.zsh 11-baku-carpet-path
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (any POSIX `sh`).
