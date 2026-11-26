# Globbing and expansion · 08 · Santiago mine maintenance office, haul truck telemetry

The maintenance office for a copper mine outside Santiago receives a telemetry log per haul truck. Truck numbers are the natural key: the night shift runs 120 to 135, the new 200-series trucks just arrived, and the old dispatch system writes `CAMION-131.LOG` in capitals. Numeric ranges, numeric sorting and case-insensitive matching handle all three.

**What it teaches**

- `<120-135>` matches any whole number in a range; `<->` matches any number
- `(n)` sorts matches numerically, so camion-99 comes before camion-101
- `(#i)` makes the rest of a pattern case-insensitive (needs `extended_glob`)
- `<200->` leaves the upper end of a range open

**Lesson steps**

1. See how a plain glob sorts numbers as text (`*`)
2. Sort numerically with (n) (`(n)`)
3. Match a range of truck numbers (`<n-m>`)
4. Match the same range in any case (`(#i)`)
5. Leave the top of the range open (`<n->`)

**Files**

| File | Role |
| --- | --- |
| [`fleet_logs.zsh`](fleet_logs.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/02-globbing-and-expansion/08-santiago-haul-trucks/fleet_logs.zsh
tests/run-examples.zsh 08-santiago-haul-trucks
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
