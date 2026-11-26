# ssh, scp, and rsync · 04 · Chiang Mai Night Bazaar gallery crates

A gallery packing for the Night Bazaar exhibition ships `crate-lanterns/` and
`crate-silk/` with `scp -r` through a local `sshd`. A `for` loop keeps the same
options for every crate.

**What it teaches**

- `scp -r` copies a whole folder tree over SSH
- a `for` loop ships each exhibition crate the same way

**Lesson steps**

1. Show the empty loading dock before the crates leave (`scp -r`)
2. scp -r each crate folder to the loading dock over local sshd (`scp -r`)
3. List the dock and the contents of each crate (`scp -r`)

**Files**

| File | Role |
| --- | --- |
| [`ship_crates.zsh`](ship_crates.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/crate-lanterns/`](fixtures/crate-lanterns/) | Lantern crate packing list |
| [`fixtures/crate-silk/`](fixtures/crate-silk/) | Silk scroll inventory |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/12-ssh-scp-rsync/04-chiang-mai-gallery-crates/ship_crates.zsh
tests/run-examples.zsh 04-chiang-mai-gallery-crates
```

The script creates its own folder with `mktemp -d`, works only inside it, kills the local `sshd` on exit, and deletes the workdir. It runs the same on macOS and Linux.
