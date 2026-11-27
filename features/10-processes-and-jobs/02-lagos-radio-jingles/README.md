# Processes and jobs · 02 · Lagos radio station, mixing jingles as background jobs

Cool FM in Lagos is mixing three jingles for the breakfast show as background jobs. `jobs -l` (redirected, because a pipe would hide them) shows the board, `%?mix_news` stops one by name, and the rest are stopped by their job numbers — which may not be `%1` after a middle job exits.

**What it teaches**

- `jobs -l` lists the shell's background jobs with process ids (redirect it; a pipe runs `jobs` in a subshell and shows nothing)
- `%1` is job number 1; `%?mix_news` matches a job whose command contains that string
- `kill %?mix_news` signals that job; the shell reaps it on the next `jobs` or `wait`
- after a middle job exits, the remaining numbers may be `%1` and `%3`, so loop on `${(k)jobtexts}` instead of assuming `%1` always exists

**Lesson steps**

1. Start the three jingles as jobs (`&`)
2. List them with jobs -l via a redirect (`jobs -l`)
3. Stop one by a command substring (`%?string`)
4. Stop the rest by their job numbers (`%n`)

**Files**

| File | Role |
| --- | --- |
| [`mix_jingles.zsh`](mix_jingles.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/10-processes-and-jobs/02-lagos-radio-jingles/mix_jingles.zsh
tests/run-examples.zsh 02-lagos-radio-jingles
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
