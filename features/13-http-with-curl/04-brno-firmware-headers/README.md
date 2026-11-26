# HTTP with curl · 04 · Brno firmware board headers

The Brno relay lab stamps every probe with board id and firmware revision
headers. A `for` loop walks alpha, beta, and gamma boards, and `curl -H` sends
both custom headers so the local echo desk can confirm them.

**What it teaches**

- `curl -H` sends one or more custom request headers with each call

**Lesson steps**

1. Probe each board with X-Board-Id and X-Firmware-Rev headers (`curl -H`)

**Files**

| File | Role |
| --- | --- |
| [`firmware_headers.zsh`](firmware_headers.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/echo_headers.py`](fixtures/echo_headers.py) | Tiny local server that echoes the custom headers |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/13-http-with-curl/04-brno-firmware-headers/firmware_headers.zsh
tests/run-examples.zsh 04-brno-firmware-headers
```

The script creates its own folder with `mktemp -d`, starts the echo server on
`127.0.0.1`, and tears both down on exit.
