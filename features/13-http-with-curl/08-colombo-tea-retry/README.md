# HTTP with curl · 08 · Colombo tea auction retry

The Colombo tea warehouse API answers 503 twice while the lot sheet is still
printing, then returns the Nuwara Eliya grade line. `curl --retry` keeps asking
until the 200 lands; a subshell pipes the final body into the report.

**What it teaches**

- `curl --retry` repeats the request after transient HTTP failures (503 here)

**Lesson steps**

1. Retry the flaky warehouse until the lot sheet arrives (`curl --retry`)

**Files**

| File | Role |
| --- | --- |
| [`tea_retry.zsh`](tea_retry.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/retry_server.py`](fixtures/retry_server.py) | Local server that fails twice, then succeeds |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/13-http-with-curl/08-colombo-tea-retry/tea_retry.zsh
tests/run-examples.zsh 08-colombo-tea-retry
```

The script creates its own folder with `mktemp -d`, starts the retry server on
`127.0.0.1`, and tears both down on exit.
