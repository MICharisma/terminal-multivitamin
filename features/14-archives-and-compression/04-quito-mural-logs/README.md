# Archives and compression · 04 · Quito mural restoration logs

Restorers on the Compañía de Jesús façade keep one journal per panel. Before the
scaffold comes down, a `for` loop `gzip`s every log; when the ochre match needs a
re-read, `gzip -d` opens panel-b again.

**What it teaches**

- a `for` loop over each log runs `gzip` in place, leaving `.gz` beside the name
- `gzip -d` restores one file when a restorer needs to re-read yesterday's notes

**Lesson steps**

1. Gzip each panel journal before the scaffold comes down (`gzip`)
2. Decompress panel-b when the pigment match needs a re-read (`gzip -d`)

**Files**

| File | Role |
| --- | --- |
| [`compress_logs.zsh`](compress_logs.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/14-archives-and-compression/04-quito-mural-logs/compress_logs.zsh
tests/run-examples.zsh 04-quito-mural-logs
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
