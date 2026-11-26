# HTTP with curl · 07 · Tromsø aurora forecast timing

The Tromsø observatory desk pulls the night's forecast and wants durable
transfer metrics, not wall-clock timing. `curl -w` prints `http_code`,
`content_type`, and `size_download` after the JSON body — never `time_total`,
which would flicker between runs.

**What it teaches**

- `curl -w` appends write-out fields after the body (use http_code, content_type, size_download — never time_total, which varies)

**Lesson steps**

1. Capture http_code, content_type, and size_download with -w (`curl -w`)

**Files**

| File | Role |
| --- | --- |
| [`aurora_timing.zsh`](aurora_timing.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/forecast.json`](fixtures/forecast.json) | Sample aurora forecast payload |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/13-http-with-curl/07-tromso-aurora-timing/aurora_timing.zsh
tests/run-examples.zsh 07-tromso-aurora-timing
```

The script creates its own folder with `mktemp -d`, serves the forecast on
`127.0.0.1`, and deletes the sandbox on exit.
