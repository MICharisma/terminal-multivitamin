# Navigation and files · 04 · Kathmandu trekking permit desk

A trekking agency in Thamel logs every TIMS permit it issues in a CSV that grows at the bottom. The desk clerk reads the header, counts the permits, checks the latest three, pulls out the Langtang group that phoned back, and numbers the rows so the Pokhara office can say "line 6" on the phone. All of it is `head`, `tail`, `wc` and `cat`.

**What it teaches**

- `head -n 1` reads a CSV header; `tail -n +2` skips it
- `tail -n 3` shows the latest rows of a log that grows at the bottom
- `head -n 7 | tail -n 3` cuts a window out of the middle of a file
- `wc -l` pads its count on macOS (BSD); `$(( ))` turns it back into a number
- `cat -n` numbers lines for a phone call about "line 6"

**Lesson steps**

1. Read the CSV header (`head -n`)
2. Count permits without the header, as a plain number (`tail -n +N`)
3. Show the latest permits at the bottom of the log (`tail -n`)
4. Cut rows 5 to 7 out of the middle (`head | tail`)
5. Number the rows for a phone call (`cat -n`)

**Files**

| File | Role |
| --- | --- |
| [`permit_desk.zsh`](permit_desk.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/permits.csv`](fixtures/permits.csv) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/01-navigation-and-files/04-kathmandu-trekking-permits/permit_desk.zsh
tests/run-examples.zsh 04-kathmandu-trekking-permits
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
