# HTTP with curl · 11 · Da Nang hotel folio upload

The front desk at a Da Nang beach hotel posts each guest card as a multipart
folio. A small function with `setopt local_options` wraps `curl -F` so the file
field and desk stamp travel together.

**What it teaches**

- `curl -F` builds a multipart/form-data body (file fields use @path)

**Lesson steps**

1. Upload the guest card as a multipart folio field (`curl -F`)

**Files**

| File | Role |
| --- | --- |
| [`hotel_upload.zsh`](hotel_upload.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/echo_upload.py`](fixtures/echo_upload.py) | Local server that echoes the uploaded filename |
| [`fixtures/guest-card.txt`](fixtures/guest-card.txt) | Sample guest folio card |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/13-http-with-curl/11-danang-hotel-upload/hotel_upload.zsh
tests/run-examples.zsh 11-danang-hotel-upload
```

The script creates its own folder with `mktemp -d`, starts the upload echo server
on `127.0.0.1`, and tears both down on exit.
