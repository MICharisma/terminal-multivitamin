# ssh, scp, and rsync · 07 · Bogotá Contadoría invoice exclude

Contadoría Andina syncs invoices to a remote desk but must leave `*.tmp` scratch
files and the `borradores/` folder behind. A `case` router builds the
`rsync --exclude` list, then one sync copies only the finished facturas.

**What it teaches**

- `rsync --exclude` skips matching files or folders during a sync
- a `case` router picks the exclude pattern for each kind of clutter

**Lesson steps**

1. Choose exclude patterns for tmp files and borradores (`rsync --exclude`)
2. rsync the desk while applying those excludes (`rsync --exclude`)
3. List the remote desk and confirm clutter stayed behind (`rsync --exclude`)

**Files**

| File | Role |
| --- | --- |
| [`sync_invoices.zsh`](sync_invoices.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/facturas/`](fixtures/facturas/) | Finished invoices plus a scratch `.tmp` |
| [`fixtures/borradores/`](fixtures/borradores/) | Draft invoice folder to exclude |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/12-ssh-scp-rsync/07-bogota-invoice-exclude/sync_invoices.zsh
tests/run-examples.zsh 07-bogota-invoice-exclude
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
