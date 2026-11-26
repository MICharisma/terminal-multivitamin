# Finding files with find and xargs · 07 · Rotterdam container terminal, sizing crane telemetry dumps

At a container terminal on the Maasvlakte, each ship-to-shore crane writes a PLC telemetry dump every morning. After sts-02 tripped its hoist brake on 20 November, the maintenance planner wants the largest dumps, everything written that day, and a per-crane total. GNU `find -printf` prints size, date and path in one go, but BSD `find` on macOS has no `-printf`, so the script tests for it once and falls back to `stat`.

**What it teaches**

- `find -printf '%s %TY-%Tm-%Td %p\n'` is GNU only; BSD `find` on macOS rejects it
- `find -exec stat -f '%z %Sm %N' -t '%Y-%m-%d' {} +` prints the same line on BSD
- detecting `-printf` once with `find . -maxdepth 0 -printf ''` and hiding both behind one function
- after that, plain text tools rank the dumps, and a `while read` loop totals them per crane; zsh runs the last command of a pipeline in the current shell, so the totals survive the loop

**Lesson steps**

1. Detect -printf once and define one listing function (`find -printf`)
2. Fall back to stat -f on BSD find (`find -exec stat -f {} +`)
3. Rank the dumps by size (`sort -rn`)
4. Pick out the day of the brake trip (`grep`)
5. Total the dumps per crane in a while-read loop (`while read -r`)

**Files**

| File | Role |
| --- | --- |
| [`telemetry_dumps.zsh`](telemetry_dumps.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/06-find-and-xargs/07-rotterdam-crane-telemetry/telemetry_dumps.zsh
tests/run-examples.zsh 07-rotterdam-crane-telemetry
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux: GNU `find` uses `-printf`, BSD `find` uses `stat -f`, and both print the same lines.
