# Globbing and expansion · 01 · Nairobi Coffee Exchange auction catalogue

Every week the Nairobi Coffee Exchange publishes a catalogue of lots, each named with its lot number, county and screen grade (AA, AB, PB, C, TT, E). A broker sends each buyer a different slice: every AA lot for a Hamburg roaster, the top screen grades for a Seoul buyer, the lower grades for blending. Each slice is one glob.

**What it teaches**

- `*` matches any run of characters; `?` matches exactly one
- `[AP][AB]` matches one character from each set (AA, AB, PB...)
- `[^AP]` (or `[!AP]`) matches any one character except those
- quoting a pattern turns globbing off, so the shell passes it literally

**Lesson steps**

1. Match every AA lot with * (`*`)
2. Match a fixed-width lot number with ? (`?`)
3. Match top screen grades with two character sets (`[...]`)
4. Exclude grades with a negated set (`[^...]`)
5. Quote a pattern to pass it literally (`'quoted'`)

**Files**

| File | Role |
| --- | --- |
| [`auction_lots.zsh`](auction_lots.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/02-globbing-and-expansion/01-nairobi-coffee-auction/auction_lots.zsh
tests/run-examples.zsh 01-nairobi-coffee-auction
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
