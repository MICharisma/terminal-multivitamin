# Environment and PATH · 04 · Almaty mountain weather desk, editing PATH as a zsh array

The mountain weather desk in Almaty edits PATH as zsh's tied `path` array: set it, prepend the forecast tools, append a duplicate, then `typeset -U path` to drop the repeat. `${(F)path}` prints one directory per line.

**What it teaches**

- in zsh, `$path` is an array tied to `$PATH`: change one and the other follows
- `path=( ~/bin $path )` prepends; `path+=( /opt/tools/bin )` appends
- `${(F)path}` prints one entry per line; `${#path}` is the count
- `typeset -U path` keeps the array unique so a directory is not searched twice

**Lesson steps**

1. Set the tied path array and watch PATH follow (`path array`)
2. Prepend and append directories (`path=( ... $path )`)
3. Drop duplicates with typeset -U (`typeset -U path`)
4. Print one entry per line with (F) (`${(F)path}`)

**Files**

| File | Role |
| --- | --- |
| [`path_array.zsh`](path_array.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/11-environment-and-path/04-almaty-path-array/path_array.zsh
tests/run-examples.zsh 04-almaty-path-array
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
