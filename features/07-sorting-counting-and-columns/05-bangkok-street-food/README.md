# Sorting, counting, and columns · 05 · Bangkok street food, cleaning the vendor sign board

Before Soi 11 night market opens, a vendor pastes chalk-menu photos into a board file with shouty caps, doubled hyphens, and messy spacing. The print shop wants lowercase, printable text. A `tr` pipeline downcases, deletes punctuation, squeezes spaces, and uses complement mode to strip symbols while keeping letters and digits.

**What it teaches**

- `tr '[:upper:]' '[:lower:]'` downcases without locale surprises when `LC_ALL=C`
- `tr -d '!.'` deletes characters from a set, useful for stray punctuation
- `tr -s ' '` squeezes runs of spaces into one
- `tr -c '[:alnum:]\n' ' '` replaces everything not in the complement set with spaces

**Lesson steps**

1. Downcase the board with character classes (`tr '[:upper:]' '[:lower:]'`)
2. Delete bangs and dots from each line (`tr -d`)
3. Squeeze repeated spaces to one (`tr -s`)
4. Blank every non-alnum character with complement (`tr -c`)

**Files**

| File | Role |
| --- | --- |
| [`vendor_cleanup.zsh`](vendor_cleanup.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/vendor-board.txt`](fixtures/vendor-board.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/07-sorting-counting-and-columns/05-bangkok-street-food/vendor_cleanup.zsh
tests/run-examples.zsh 05-bangkok-street-food
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
