# HTTP with curl · 09 · Stuttgart parts catalog download

A Stuttgart machine shop pulls bearing and seal sheets from the parts board.
An anonymous function with `emulate -L zsh` walks the part list, and `curl -O`
saves each body under the remote file name in the workdir.

**What it teaches**

- `curl -O` writes the body to a file named after the remote path's final segment (bearing-6204.txt, seal-nitrile.txt)

**Lesson steps**

1. Download each sheet with the remote file name (`curl -O`)
2. List the sheets that landed in the workdir (`curl -O`)

**Files**

| File | Role |
| --- | --- |
| [`parts_catalog.zsh`](parts_catalog.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/bearing-6204.txt`](fixtures/bearing-6204.txt) | Bearing stock sheet |
| [`fixtures/seal-nitrile.txt`](fixtures/seal-nitrile.txt) | Seal stock sheet |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/13-http-with-curl/09-stuttgart-parts-catalog/parts_catalog.zsh
tests/run-examples.zsh 09-stuttgart-parts-catalog
```

The script creates its own folder with `mktemp -d`, serves the catalog on
`127.0.0.1`, and deletes the sandbox on exit.
