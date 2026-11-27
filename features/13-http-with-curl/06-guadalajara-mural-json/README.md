# HTTP with curl · 06 · Guadalajara mural JSON submission

The Tlaquepaque mural registry takes new wall records as JSON. An associative
array holds title, district, and panel count; `curl --json` posts them in one
shot and prints the confirmation body.

**What it teaches**

- `curl --json` POSTs a JSON body and sets Content-Type: application/json

**Lesson steps**

1. POST the barrio mural fields as JSON (`curl --json`)

**Files**

| File | Role |
| --- | --- |
| [`mural_json.zsh`](mural_json.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/echo_json.py`](fixtures/echo_json.py) | Local server that echoes a JSON confirmation |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/13-http-with-curl/06-guadalajara-mural-json/mural_json.zsh
tests/run-examples.zsh 06-guadalajara-mural-json
```

The script creates its own folder with `mktemp -d`, starts the JSON echo server
on `127.0.0.1`, and tears both down on exit.
