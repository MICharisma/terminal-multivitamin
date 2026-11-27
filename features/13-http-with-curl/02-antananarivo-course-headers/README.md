# HTTP with curl · 02 · Antananarivo course material headers

At the University of Antananarivo oral-history desk, the clerk checks whether a
course file is JSON or plain text before opening it. `curl -I` prints the status
line; `curl -sI` feeds Content-Type into a `case` router.

**What it teaches**

- `curl -I` asks for headers only (HEAD), without downloading the body
- `curl -sI` does the same quietly so you can branch on Content-Type

**Lesson steps**

1. Probe syllabus and reading-list status lines with HEAD (`curl -I`)
2. Read Content-Type quietly and route each file (`curl -sI`)

**Files**

| File | Role |
| --- | --- |
| [`course_headers.zsh`](course_headers.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/syllabus.json`](fixtures/syllabus.json) | JSON course summary |
| [`fixtures/reading-list.txt`](fixtures/reading-list.txt) | Plain-text reading list |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/13-http-with-curl/02-antananarivo-course-headers/course_headers.zsh
tests/run-examples.zsh 02-antananarivo-course-headers
```

The script creates its own folder with `mktemp -d`, serves both files on
`127.0.0.1`, and deletes the sandbox on exit. Only status lines and Content-Type
values are printed — never the ephemeral port.
