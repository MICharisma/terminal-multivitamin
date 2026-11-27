# macOS system tools · 04 · Rabat facilities power audit

The facilities desk at a Rabat technical institute audits Mac mini sleep settings without changing them. `pmset -g` is read-only; awk prints only whether known keys exist, never the machine-specific numbers.

**What it teaches**

- `pmset -g` dumps the live power profile (read-only)
- awk normalizes the dump to key-present lines so expected output stays stable
- nothing calls `pmset` with a write verb

**Lesson steps**

1. Ask pmset for the live profile (`pmset -g`)
2. Normalize keys so the ledger stays stable (`awk normalize`)

**Files**

| File | Role |
| --- | --- |
| [`power_audit.zsh`](power_audit.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/18-macos-system-tools/04-rabat-power-audit/power_audit.zsh
tests/run-examples.zsh 04-rabat-power-audit
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
