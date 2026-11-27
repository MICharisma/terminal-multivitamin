# HTTP with curl · 05 · Dakar festival ticket form

The Festival International de Jazz de Dakar box office takes holds as form posts.
A quick soundcheck seat uses plain `curl -d`; the evening plan file walks artist
names through `--data-urlencode` so spaces and apostrophes survive.

**What it teaches**

- `curl -d` posts application/x-www-form-urlencoded fields
- `--data-urlencode` percent-encodes values that contain spaces or punctuation

**Lesson steps**

1. Post a soundcheck hold with plain -d fields (`curl -d`)
2. Encode each artist name from the plan file (`--data-urlencode`)

**Files**

| File | Role |
| --- | --- |
| [`ticket_form.zsh`](ticket_form.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/echo_form.py`](fixtures/echo_form.py) | Local server that echoes parsed form fields |
| [`fixtures/ticket-plan.txt`](fixtures/ticket-plan.txt) | Artist / night / seats plan |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/13-http-with-curl/05-dakar-ticket-form/ticket_form.zsh
tests/run-examples.zsh 05-dakar-ticket-form
```

The script creates its own folder with `mktemp -d`, starts the form echo server
on `127.0.0.1`, and tears both down on exit.
