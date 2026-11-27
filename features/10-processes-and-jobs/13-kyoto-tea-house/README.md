# Processes and jobs · 13 · Kyoto tea house, keeping the Mac awake for a long steep

A tea house in Gion, Kyoto, starts a gyokuro steep timer and points `caffeinate -w` at its pid so the Mac will not idle-sleep mid-steep. When the timer exits, `caffeinate` exits too. macOS only; the Linux job skips it.

**What it teaches**

- `caffeinate -w $pid` stays running until that process exits, and holds idle sleep off
- start the steep timer first, then point `caffeinate` at its pid
- when the timer exits, `caffeinate` exits too: `wait` on both
- macOS only; on Linux the script prints a message and exits 2

**Lesson steps**

1. Start the steep timer in the background (`&`)
2. Point caffeinate at the timer pid (`caffeinate -w`)
3. Wait for both to exit (`wait $pid`)

**Files**

| File | Role |
| --- | --- |
| [`caffeinate_timer.zsh`](caffeinate_timer.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/10-processes-and-jobs/13-kyoto-tea-house/caffeinate_timer.zsh
tests/run-examples.zsh 13-kyoto-tea-house
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS (`caffeinate`); on Linux it prints a message and exits 2, and the test runner skips it.
