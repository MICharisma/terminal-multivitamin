# Permissions and ownership · 09 · Port of Rotterdam planning office, auditing a shared drive

The berth-planning office at the Port of Rotterdam shares one drive: weekly berth lists for Maasvlakte and Euromax, the pilots' roster, customs scans copied off a USB stick, and a drop-in inbox. Before an IT audit, the script finds every world-writable file, every open folder without the sticky bit, and the PDFs that picked up an execute bit from the stick, using only `find -perm` forms that work in both GNU and BSD `find`, then fixes them with a single `-exec chmod ... {} +` per rule.

**What it teaches**

- `find -perm -0002` matches files with *at least* those bits (here: others may write)
- combining tests: world-writable folders without the sticky bit are `-perm -0002 ! -perm -1000`
- "any of these bits" is `-perm /022` in GNU find and `-perm +022` in old BSD find; `\( -perm -0020 -o -perm -0002 \)` works in both
- `-exec chmod o-w {} +` fixes everything found in a few `chmod` calls, not one per file
- `find` lists in directory order, so `sort` the report before comparing it

**Lesson steps**

1. Find files anyone can change (`find -perm -0002`)
2. Find open folders without the sticky bit (`find ! -perm -1000`)
3. Match any of several bits portably (`find \( -perm -0020 -o -perm -0002 \)`)
4. Fix everything found in one pass (`find -exec chmod {} +`)

**Files**

| File | Role |
| --- | --- |
| [`audit_drive.zsh`](audit_drive.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/09-permissions-and-ownership/09-rotterdam-port-shared-drive/audit_drive.zsh
tests/run-examples.zsh 09-rotterdam-port-shared-drive
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
