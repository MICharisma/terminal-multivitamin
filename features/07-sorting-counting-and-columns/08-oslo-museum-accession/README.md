# Sorting, counting, and columns · 08 · Oslo museum accession, reconciling photo day with the register

After a photography day at the new Munch wing, two sorted id lists exist: objects accessioned in the register and objects that got photos. `comm` compares sorted line lists. Suppressing different column pairs shows accessions still waiting for photos, photos ahead of paperwork, and ids ready for the website.

**What it teaches**

- `comm` compares two sorted line lists and only works when both inputs are ordered
- `comm -23` prints lines only in the first file (accessioned but not photographed)
- `comm -13` prints lines only in the second file (photographed before paperwork)
- `comm -12` prints lines in both files (ready for the website)

**Lesson steps**

1. List accessioned ids not on the photo sheet (`comm -23`)
2. List photographed ids missing from the register (`comm -13`)
3. List ids present in both sorted files (`comm -12`)

**Files**

| File | Role |
| --- | --- |
| [`photo_reconcile.zsh`](photo_reconcile.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/accessioned.txt`](fixtures/accessioned.txt) | Fixture copied into the script's temp folder |
| [`fixtures/photographed.txt`](fixtures/photographed.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/07-sorting-counting-and-columns/08-oslo-museum-accession/photo_reconcile.zsh
tests/run-examples.zsh 08-oslo-museum-accession
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
