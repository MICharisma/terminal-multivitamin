# HTTP with curl · 12 · Thessaloniki grade roster with jq

The State Conservatory of Thessaloniki publishes the Byzantine chant roster as
JSON. A pipeline pulls it with `curl` and shapes it with `jq -r`: first every
name, then only the students who passed.

**What it teaches**

- `jq -r` prints raw strings without JSON quotes
- `jq` filters and projects nested JSON fields

**Lesson steps**

1. Print every student name as a raw string (`jq -r`)
2. Keep only students with grade 15 or higher (`jq`)

**Files**

| File | Role |
| --- | --- |
| [`grades_jq.zsh`](grades_jq.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/roster.json`](fixtures/roster.json) | Sample grade roster |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/13-http-with-curl/12-thessaloniki-grades-jq/grades_jq.zsh
tests/run-examples.zsh 12-thessaloniki-grades-jq
```

The script creates its own folder with `mktemp -d`, serves the roster on
`127.0.0.1`, and deletes the sandbox on exit.
