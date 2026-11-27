# Globbing and expansion · 13 · Seoul webtoon studio, renumbering exported panels

A webtoon studio in Seoul collects panels from three artists' tablets: `ep3_panel1.png`, `EP12_Panel2.PNG`, and a stray duplicate `ep3_panel02.png`. The platform wants `ep003/panel01.png`. `zmv` renames the whole batch by pattern, refuses when two panels would collide, previews with `-n`, and then moves panels into episode folders.

**What it teaches**

- `zmv` renames by pattern; `(...)` in the source becomes `$1`, `$2` in the target
- `zmv -n` prints the plan without touching anything
- `zmv` refuses the whole batch when two files would land on one name
- `${(l:3::0:)1}` pads a capture with zeros on the left
- `zmv -W` uses plain `*` on both sides, here to move files into folders named with `${(u)...}` from the matches themselves

**Lesson steps**

1. Watch zmv refuse a batch with a collision (`zmv`)
2. Print the rename plan without moving anything (`zmv -n`)
3. Rename with zero-padded captures (`${(l:3::0:)1}`)
4. Move panels into episode folders with zmv -W (`zmv -W`)

**Files**

| File | Role |
| --- | --- |
| [`renumber_panels.zsh`](renumber_panels.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/02-globbing-and-expansion/13-seoul-webtoon-studio/renumber_panels.zsh
tests/run-examples.zsh 13-seoul-webtoon-studio
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
