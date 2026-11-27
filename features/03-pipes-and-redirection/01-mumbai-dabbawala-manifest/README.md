# Pipes and redirection · 01 · Mumbai dabbawala lunch manifest

A dabbawala team in Andheri collects home-cooked lunches every morning and sorts them by destination station before the Churchgate train. The manifest is a plain text file: written fresh with `>` at 9:00, extended with `>>` as late calls come in, and counted per station with a pipeline. Then the two classic accidents: replacing a file you meant to keep, and sorting a file into itself.

**What it teaches**

- `>` creates a file, or empties an existing one, before the command writes; `>>` adds to the end
- `|` feeds one command's output to the next: `cut | sort | uniq -c` counts tiffins per station
- `uniq -c` pads its counts differently on BSD and GNU; `read` strips the padding
- `setopt noclobber` makes `>` refuse to replace a file; `>|` replaces it on purpose
- `sort f > f` empties `f` before `sort` opens it: sort into a new file, then `mv`

**Lesson steps**

1. Write the morning pickups to a fresh manifest (`>`)
2. Append the late phone orders (`>>`)
3. Count tiffins per station with a pipeline (`|`)
4. Refuse to overwrite with noclobber, then override with >| (`>|`)
5. See sort empty its own input, then sort the safe way (`sort f > f.new && mv`)

**Files**

| File | Role |
| --- | --- |
| [`lunch_manifest.zsh`](lunch_manifest.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/03-pipes-and-redirection/01-mumbai-dabbawala-manifest/lunch_manifest.zsh
tests/run-examples.zsh 01-mumbai-dabbawala-manifest
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
