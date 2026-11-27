# HTTP with curl · 10 · Luanda clinic redirect chain

The Luanda community clinic moved intake to `/wards/intake.txt` but left a 302
at `/clinic`. Without `-L` the desk only sees status 302; with `curl -L` the
patient line comes through.

**What it teaches**

- `curl -L` follows Location redirects (here a 302 from /clinic to intake)

**Lesson steps**

1. See the bare 302 when redirects are not followed (`curl -w`)
2. Follow the intake Location with curl -L (`curl -L`)

**Files**

| File | Role |
| --- | --- |
| [`clinic_redirect.zsh`](clinic_redirect.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/redirect_server.py`](fixtures/redirect_server.py) | Local server with a 302 intake redirect |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/13-http-with-curl/10-luanda-clinic-redirect/clinic_redirect.zsh
tests/run-examples.zsh 10-luanda-clinic-redirect
```

The script creates its own folder with `mktemp -d`, starts the redirect server on
`127.0.0.1`, and tears both down on exit.
