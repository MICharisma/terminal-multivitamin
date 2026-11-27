# Finding files with find and xargs · 02 · Istanbul ferry engine logs since the dry-dock inspection

Three Bosphorus commuter ferries, the Moda, the Kartal and the Barış Manço, write an engine log after every evening shift. The ferries went through a dry-dock inspection at Hasköy on 8 November, and the chief engineer wants the logs from after it, the ones from before it for the shipyard, and the Kartal's logs from the days its coolant alarm sounded. The inspection report itself is the reference file, so `-newer` needs no date parsing at all.

**What it teaches**

- `-newer report.txt` matches files modified after the reference file was
- `! -newer` means "not newer": older, or exactly as old
- two reference files made with `touch -t` mark a date window, with no date parsing, so BSD and GNU `find` agree
- `cp` without `-p` stamps the copy with the current time, so `-newer` sees it as new

**Lesson steps**

1. List the logs written after the inspection report (`find -newer`)
2. Negate the test for the logs from before it (`find ! -newer`)
3. Bracket a date window with two touch -t stamps (`find -newer a ! -newer b`)
4. See why a plain cp looks new and cp -p does not (`cp -p`)

**Files**

| File | Role |
| --- | --- |
| [`engine_logs.zsh`](engine_logs.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/06-find-and-xargs/02-istanbul-ferry-engine-logs/engine_logs.zsh
tests/run-examples.zsh 02-istanbul-ferry-engine-logs
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
