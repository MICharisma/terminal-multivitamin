# Quoting and parameter expansion · 08 · Dakar fishing cooperative, tallying the morning landing

At the Soumbédioune beach landing in Dakar, each pirogue reports its catch: boat, species, kilograms. An associative array tallies kilograms per species, lists the boats, checks whether barracuda arrived, and finds the heaviest species for the Kermel market.

**What it teaches**

- `typeset -A catch` declares an associative array (a table keyed by name)
- `(( catch[$species] += kg ))` adds to a key, starting from nothing
- `${(k)catch}` lists keys, `${(v)catch}` values, `${(kv)catch}` pairs; `(o)` sorts them
- `${+catch[barracuda]}` is 1 if the key exists, 0 if not, without tripping `nounset`
- `${(k)catch[(r)180]}` looks up a key by its value

**Lesson steps**

1. Declare an associative array (`typeset -A`)
2. Accumulate kilograms per species (`(( assoc[$k] += n ))`)
3. Walk keys and values (`${(kv)assoc}`)
4. Test whether a key exists (`${+assoc[key]}`)
5. Look up a key by its value (`${(k)assoc[(r)val]}`)

**Files**

| File | Role |
| --- | --- |
| [`landing_tally.zsh`](landing_tally.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/04-quoting-and-parameter-expansion/08-dakar-fishing-cooperative/landing_tally.zsh
tests/run-examples.zsh 08-dakar-fishing-cooperative
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
