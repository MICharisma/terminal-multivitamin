# Environment and PATH · 06 · Valletta dive school, asking the shell where each tool is

A dive school in Valletta asks the shell where each tool lives: `command -v` for a portable answer, `whence -v` to tell alias from builtin from executable, `type -a` for every match on PATH, and `which` for interactive use.

**What it teaches**

- `command -v name` is the portable "does it exist, and where?"
- `whence -v` (zsh) says whether it is an alias, function, builtin, or executable
- `type -a` lists every match on PATH, not just the first
- `which` is common but not POSIX; prefer `command -v` in scripts

**Lesson steps**

1. Locate tools with command -v (`command -v`)
2. Classify them with whence -v (`whence -v`)
3. List every ls on PATH with type -a (`type -a`)
4. Use which interactively (`which`)

**Files**

| File | Role |
| --- | --- |
| [`resolve_tools.zsh`](resolve_tools.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/11-environment-and-path/06-valletta-dive-tools/resolve_tools.zsh
tests/run-examples.zsh 06-valletta-dive-tools
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
