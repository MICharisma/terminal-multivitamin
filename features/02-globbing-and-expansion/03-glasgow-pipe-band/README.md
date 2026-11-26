# Globbing and expansion · 03 · Glasgow pipe band repertoire scores

A Glasgow pipe band keeps its LilyPond scores by set (march-strathspey-reel, medley), then by tune type. The pipe major wants every reel wherever it lives, a count of all scores, and the competition set linked under a second name. `**/` searches every depth, and `***/` also follows the link.

**What it teaches**

- `**/` matches any depth of folders, including none
- collecting matches into an array and counting them with `${#array}`
- `**/reel/*.ly` anchors a recursive search on one folder name
- `**/` does not follow symlinked folders; `***/` does

**Lesson steps**

1. Collect every score at any depth (`**/`)
2. Find every reel by anchoring on a folder name (`**/`)
3. Compare fixed-depth patterns (`*/*`)
4. Follow symlinked folders with ***/ (`***/`)

**Files**

| File | Role |
| --- | --- |
| [`repertoire.zsh`](repertoire.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/02-globbing-and-expansion/03-glasgow-pipe-band/repertoire.zsh
tests/run-examples.zsh 03-glasgow-pipe-band
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
