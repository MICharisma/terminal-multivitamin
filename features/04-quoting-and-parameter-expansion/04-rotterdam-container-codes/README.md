# Quoting and parameter expansion · 04 · Rotterdam container terminal, decoding manifest file names

At the Maasvlakte gate in Rotterdam, each arriving container leaves a JSON file named with its ISO 6346 number, size code, and check reason. Parameter expansion strips the folders, peels fields off the name, slices the container number, and rewrites the size code for the gate screen.

**What it teaches**

- `${path##*/}` strips the longest match from the front (the folders); `${path%/*}` strips from the end
- one `#` or `%` removes the shortest match, two remove the longest: `${name%%_*}` vs `${name%_*}`
- `${id:0:4}` and `${id:4:6}` slice by position; `${id: -1}` counts from the end (note the space)
- `${size/45G1/40ft high cube}` replaces the first match; `${path//\//:}` replaces every one

**Lesson steps**

1. Strip folders with ## and % (`${path##*/}`)
2. Compare shortest and longest suffix removal (`${name%%_*}`)
3. Slice the container number by position (`${id:0:4}`)
4. Replace size codes and every slash (`${var/old/new}`)

**Files**

| File | Role |
| --- | --- |
| [`container_codes.zsh`](container_codes.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/04-quoting-and-parameter-expansion/04-rotterdam-container-codes/container_codes.zsh
tests/run-examples.zsh 04-rotterdam-container-codes
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
