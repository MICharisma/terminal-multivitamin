# Finding files with find and xargs · 08 · Bogotá university library, fixity checksums for the thesis repository

A university library in Bogotá deposits this year's graduate theses from engineering, medicine and the arts in its digital repository, and records a checksum for each PDF so later copies can be checked. `xargs -n` splits the list into batches, `xargs -P` checksums several batches at once, and a sorted manifest makes the run repeatable. The law faculty has deposited nothing yet, which is where GNU and BSD `xargs` part ways. A month later one thesis gets a corrected abstract, and comparing manifests finds it.

**What it teaches**

- `xargs -n 4` caps each command at four arguments, so ten theses take three runs
- `xargs -P 3` runs up to three commands at once; their output arrives in any order, so sort it before you save it
- `cksum` prints the same POSIX CRC, size and name on macOS and Linux, which makes it a portable fixity check
- with no input, GNU `xargs` still runs `cksum` once (which then checksums an empty stdin) unless given `-r`; BSD `xargs` never runs on empty input, so add `-r` only where it is accepted
- comparing two sorted manifests with `diff` names the one file that changed

**Lesson steps**

1. See how xargs -n 4 splits ten theses into batches (`xargs -n`)
2. Checksum in parallel and sort the manifest (`xargs -P`)
3. Record a portable CRC for each thesis (`cksum`)
4. Skip the command on empty input with -r where xargs accepts it (`xargs -r`)
5. Find the thesis that changed since the deposit (`diff`)

**Files**

| File | Role |
| --- | --- |
| [`fixity_manifest.zsh`](fixity_manifest.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/06-find-and-xargs/08-bogota-thesis-checksums/fixity_manifest.zsh
tests/run-examples.zsh 08-bogota-thesis-checksums
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
