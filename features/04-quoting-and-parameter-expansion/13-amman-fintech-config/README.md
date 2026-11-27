# Quoting and parameter expansion · 13 · Amman fintech ops, resolving nested deploy config

Ops at a fintech in Amman resolve deploy config from role names: `api` → `$api_host`, a staging template re-evaluated with `(e)`, log paths walked with stacked trims and `:h`/`:t` (never assign to `$path` in zsh: it is tied to `$PATH`), and a status line dated with `${(%)line}`.

**What it teaches**

- `${(P)name}` expands the variable whose name is in `$name` (indirect expansion)
- `${(P)${:-${role}_host}}` builds the name first, then looks it up: `api` → `$api_host`
- `${(e)template}` re-evaluates `$` inside a string after you build the string
- `${${logpath%/*/*}##*/}` stacks trims; path modifiers `:h` `:t` walk a path without clobbering `$path`
- `${(%)line}` expands prompt sequences like `%D{%Y-%m-%d}` for a status line
- never assign to `$path` in zsh: it is tied to `$PATH`, and a string assignment wipes the PATH

**Lesson steps**

1. Expand a variable whose name is in another variable (`${(P)name}`)
2. Build the name from a role, then look it up (`${(P)${:-${role}_host}}`)
3. Re-evaluate a URL template with (e) (`${(e)template}`)
4. Stack two trims to get the service name (`${${var%/*/*}##*/}`)
5. Walk the same path with :h and :t (`:h :t`)
6. Expand prompt escapes in a status line (`${(%)line}`)

**Files**

| File | Role |
| --- | --- |
| [`resolve_config.zsh`](resolve_config.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/04-quoting-and-parameter-expansion/13-amman-fintech-config/resolve_config.zsh
tests/run-examples.zsh 13-amman-fintech-config
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
