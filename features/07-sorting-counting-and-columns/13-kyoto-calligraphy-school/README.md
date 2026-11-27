# Sorting, counting, and columns · 13 · Kyoto calligraphy school, reflowing a practice stroke grid

Gion brush school stores practice stroke names (ei, hyo, shin, gyo, so, kai) one per line for tracing software. macOS BSD `rs` reshapes that grid into printable rows: four strokes per row for wall charts and two per row for a narrow booklet. Linux does not ship `rs` by default, so this slot is macOS only.

**What it teaches**

- BSD `rs` reshapes one-character-per-line grids into columns for printing
- `rs 0 4` keeps four columns per row and as many rows as needed
- `rs 0 2` reshapes the same grid into two columns for the narrow practice booklet

**Lesson steps**

1. Reflow the grid to four columns per row (`rs -e 0 4`)
2. Reflow the same grid to two columns (`rs -e 0 2`)

**Files**

| File | Role |
| --- | --- |
| [`grid_reflow.zsh`](grid_reflow.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/stroke-grid.txt`](fixtures/stroke-grid.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/07-sorting-counting-and-columns/13-kyoto-calligraphy-school/grid_reflow.zsh
tests/run-examples.zsh 13-kyoto-calligraphy-school
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. Requires macOS; Linux runners skip it.
