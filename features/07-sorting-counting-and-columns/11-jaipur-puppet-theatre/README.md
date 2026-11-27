# Sorting, counting, and columns · 11 · Jaipur puppet theatre, counting cues for the night show

At the Rangmahal puppet theatre in Jaipur, the call sheet for tonight's show is a plain list of cues in performance order: drummer repeats, lion mask, narrator, prince and princess. The puppet master wants a frequency tally and the top two cues saved for the call sheet. This slot is in bash so a process-substitution loop can fill an array that survives the pipe, and it works on macOS's bash 3.2 without `mapfile`.

**What it teaches**

- in bash, `sort | uniq -c` with a function still pads counts differently on BSD and GNU; `read -r count label` drops the padding
- process substitution `< <(...)` keeps the loop in the current shell so a ranked array survives
- works in macOS's bash 3.2: build the array with `ranked+=("$row")` instead of `mapfile`

**Lesson steps**

1. Tally cues with sort and uniq -c (`sort | uniq -c`)
2. Save ranked tallies in a bash 3.2 array (`array+=("$item")`)

**Files**

| File | Role |
| --- | --- |
| [`cue_tally.bash`](cue_tally.bash) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/show-cues.txt`](fixtures/show-cues.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/07-sorting-counting-and-columns/11-jaipur-puppet-theatre/cue_tally.bash
tests/run-examples.zsh 11-jaipur-puppet-theatre
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux, including macOS's bash 3.2.
