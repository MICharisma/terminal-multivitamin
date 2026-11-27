# HTTP with curl · 01 · Valparaíso Saturday ferry timetable

The ferry office in Valparaíso posts the Saturday crossing sheet on a small local
board. The clerk pulls it once with `curl -sS -o` so the body lands in
`ferry-saturday.txt` without progress noise, then peeks at the first crossings.

**What it teaches**

- `curl -o` writes the response body to a named file instead of stdout
- `curl -sS` stays quiet on progress but still shows errors

**Lesson steps**

1. Save the Saturday timetable into ferry-saturday.txt (`curl -o`)
2. Fetch quietly with -sS so only the body lands in the file (`curl -sS`)

**Files**

| File | Role |
| --- | --- |
| [`ferry_timetable.zsh`](ferry_timetable.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/saturday.txt`](fixtures/saturday.txt) | Sample crossing sheet served by the local http.server |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/13-http-with-curl/01-valparaiso-ferry-timetable/ferry_timetable.zsh
tests/run-examples.zsh 01-valparaiso-ferry-timetable
```

The script creates its own folder with `mktemp -d`, serves the timetable on
`127.0.0.1`, works only inside the sandbox, and deletes it on exit.
