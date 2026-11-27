# Archives and compression · 10 · Cork lab datasets

An environmental lab on the River Lee keeps pH CSVs for three stations. An
associative array maps each station to its file; the script copies into
`compressed/` and `gzip`s the copy so the raw CSV stays put.

**What it teaches**

- an associative array maps dataset ids to source files
- gzip a copy (not the original) so the lab keeps the raw CSV beside the `.gz`

**Lesson steps**

1. Map each river station to its raw CSV in an associative array (`gzip`)
2. Copy each dataset and gzip the copy (`gzip`)
3. Show that raw CSVs remain beside the .gz files (`gzip`)

**Files**

| File | Role |
| --- | --- |
| [`gzip_datasets.zsh`](gzip_datasets.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/14-archives-and-compression/10-cork-lab-datasets/gzip_datasets.zsh
tests/run-examples.zsh 10-cork-lab-datasets
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
