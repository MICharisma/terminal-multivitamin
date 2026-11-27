# HTTP with curl · 13 · Hobart release manifest

The Southern Lights release desk in Hobart pulls one signed manifest per cut.
A function pipelines `curl -fsSL` with auth headers and `-w '%{http_code}'` into
a saved JSON file; `jq -r` then lists every active channel. Capstone for the
feature: quiet fail-loud fetch, custom headers, write-out status, and jq.

**What it teaches**

- combine `curl -fsSL`, `curl -H`, `curl -w`, and `jq` on one release pull

**Lesson steps**

1. Fetch the manifest with -fsSL and auth headers (`curl -fsSL`)
2. Send Authorization and Accept headers (`curl -H`)
3. Capture the HTTP status with -w while saving the body (`curl -w`)
4. List active release channels with jq (`jq -r`)

**Files**

| File | Role |
| --- | --- |
| [`release_manifest.zsh`](release_manifest.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/manifest.json`](fixtures/manifest.json) | Sample multi-channel release manifest |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/13-http-with-curl/13-hobart-release-manifest/release_manifest.zsh
tests/run-examples.zsh 13-hobart-release-manifest
```

The script creates its own folder with `mktemp -d`, serves the manifest on
`127.0.0.1`, and deletes the sandbox on exit.
