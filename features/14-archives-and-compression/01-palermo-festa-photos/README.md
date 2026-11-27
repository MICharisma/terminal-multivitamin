# Archives and compression · 01 · Palermo festa birthday photos

The Rossi cousins shot Nonna Maria's birthday festa in the courtyard and want
one archive to send to the relatives in Catania. `tar -czf` packs the three
photos; `tar -tf` lists the members by name so the listing stays the same on
every machine.

**What it teaches**

- `tar -czf` packs named files into a gzipped archive in one shot
- `tar -tf` lists member names only (no dates or owners that vary by machine)

**Lesson steps**

1. Pack the three festa photos into a gzipped tar (`tar -czf`)
2. List the archive members by name only (`tar -tf`)

**Files**

| File | Role |
| --- | --- |
| [`festa_album.zsh`](festa_album.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/14-archives-and-compression/01-palermo-festa-photos/festa_album.zsh
tests/run-examples.zsh 01-palermo-festa-photos
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
