# macOS system tools · 08 · Lhasa archive catalog queries

A manuscript archive in Lhasa keeps Spotlight query strings for recurring catalog searches. An associative array maps shelf names to `mdfind` queries; the script prints each query and runs it, reporting only whether the tool exited zero (Spotlight may return no hits in a fresh sandbox).

**What it teaches**

- an associative array holds shelf → query pairs
- `mdfind` runs each query; empty results are fine in a temp sandbox
- the ledger records query text and exit status, never fluctuating hit lists

**Lesson steps**

1. Walk shelf and query pairs (`${(kv)array}`)
2. Run each catalog query with mdfind (`mdfind`)

**Files**

| File | Role |
| --- | --- |
| [`catalog_queries.zsh`](catalog_queries.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/18-macos-system-tools/08-lhasa-archive-catalog/catalog_queries.zsh
tests/run-examples.zsh 08-lhasa-archive-catalog
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
