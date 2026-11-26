# Archives and compression · 09 · Ulaanbaatar core sample archive

A geology team at the Mongolian University of Science and Technology keeps
borehole-14 samples in one tarball. `tar -tf` inventories the members; `tar -xOf`
prints the 18m mudstone note to stdout without unpacking the tree.

**What it teaches**

- `tar -tf` inventories every member before you touch the disk
- `tar -xOf` extracts one member to stdout so a geologist can peek without unpacking

**Lesson steps**

1. List every member in the borehole archive (`tar -tf`)
2. Peek at the 18m mudstone sample on stdout (`tar -xOf`)
3. Confirm the workdir never unpacked the tree (`tar -xOf`)

**Files**

| File | Role |
| --- | --- |
| [`peek_core.zsh`](peek_core.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/14-archives-and-compression/09-ulaanbaatar-core-sample/peek_core.zsh
tests/run-examples.zsh 09-ulaanbaatar-core-sample
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
