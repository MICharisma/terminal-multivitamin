# Archives and compression · 05 · Tunis oud recording stems

At a Medina recording room, three oud stems sit as raw takes. The engineer
measures their byte sizes, runs `xz` on each, then `xz -d` restores the taksim
when the mix needs the uncompressed take again.

**What it teaches**

- `xz` compresses a single stem file in place to `.xz`
- `wc -c` on deterministic content shows the size drop without locale padding tricks
- `xz -d` restores a stem when the mix engineer needs the raw take again

**Lesson steps**

1. Measure each stem's byte size before compression (`xz`)
2. Compress every stem with xz and show the new sizes (`xz`)
3. Decompress the taksim stem when the mix needs the raw take (`xz -d`)

**Files**

| File | Role |
| --- | --- |
| [`squeeze_stems.zsh`](squeeze_stems.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/14-archives-and-compression/05-tunis-oud-stems/squeeze_stems.zsh
tests/run-examples.zsh 05-tunis-oud-stems
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
