# Processes and jobs

What is running, and how to wait for it or stop it: background `&`, `$!`,
`wait`, `jobs` and job specs (`%1`, `%?name`), `ps`, `pgrep`/`pkill`, signals
(`TERM`, `HUP`, `USR1`, `STOP`), process groups, `nohup`, `trap EXIT`, zsh's
`time`/`TIMEFMT`, `lsof`, portable `sh` waits, and macOS `caffeinate -w`.

A few habits that keep these examples safe and deterministic:

| Habit | Why |
| --- | --- |
| Keep a pid list and `kill` it in an `EXIT` trap | A failed run must leave no orphans; the test runner checks |
| Prefer `pgrep -f 'unique-marker:'` over `ps \| grep` | Grep races against itself and matches strangers |
| Redirect `jobs -l > file`, do not pipe it | A pipe runs `jobs` in a subshell and shows nothing |
| `kill -- -$pgid` for a whole batch | One signal reaches every child in the process group |
| `time` on an external command, not a function | zsh's `time` is silent for shell functions |

Official references: `man zshbuiltins` (`wait`, `jobs`, `kill`, `trap`, `time`),
`man ps`, `man pgrep`, `man lsof`, and on macOS `man caffeinate`.

## Examples (13 of 13 built)

01. [Porto wine lodge, counting bottles in three lodges at once](01-porto-bottle-counts/) — available
02. [Lagos radio station, mixing jingles as background jobs](02-lagos-radio-jingles/) — available
03. [Prague tram depot, reading the night shift's process list](03-prague-tram-depot/) — available
04. [Chiang Mai temple school, signalling the lantern crew](04-chiang-mai-lantern-crew/) — available
05. [Montréal bike cooperative, a repair desk that listens for signals](05-montreal-bike-coop/) — available
06. [Auckland ferry timetable desk, waiting on each sailing's check](06-auckland-ferry-timetable/) — available
07. [Amman pharmacy, stopping a whole labelling batch with one signal](07-amman-pharmacy-batch/) — available
08. [Lyon bakery, leaving the overnight bake running under nohup](08-lyon-bakery-overnight/) — available
09. [Bogotá observatory, timing plate exposures with zsh's time](09-bogota-observatory/) — available
10. [Riga puppet theatre, cleaning up stage workers with trap](10-riga-puppet-theatre/) — available
11. [Muscat desalination plant, finding who holds the valve lock](11-muscat-desalination-lock/) — available
12. [Antananarivo rice mill, waiting on baggers in portable sh](12-antananarivo-rice-mill/) — available
13. [Kyoto tea house, keeping the Mac awake for a long steep](13-kyoto-tea-house/) — available, macOS only

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Wine lodge (business) | `&`, `$!`, `wait $pid`, bare `wait`, EXIT trap |
| 02 | Radio station (music) | `jobs -l` via redirect, `%?string`, `%n`, `$jobtexts` |
| 03 | Tram depot (mechanical) | `ps -o` columns, `ps -p`, state `T` via `STOP`, no grep |
| 04 | Temple school (education) | `exec -a`, `pgrep -P`/`-f`, `pkill` |
| 05 | Bike cooperative (tech) | `trap` for `USR1`/`HUP`/`TERM`, `kill -USR1` |
| 06 | Ferry desk (hospitality) | `wait $pid` exit status, timetable vs launch order |
| 07 | Pharmacy (business) | `setsid` process group, `kill -- -$pgid` |
| 08 | Bakery (family) | `nohup`, HUP ignored, log survives |
| 09 | Observatory (science) | `TIMEFMT`, `time` on an external command |
| 10 | Puppet theatre (art) | `trap EXIT`, failure path with `return 1`, no orphans |
| 11 | Desalination plant (mechanical) | `exec {fd}<>`, `lsof` / `lsof -t` |
| 12 | Rice mill (mechanical) | POSIX `sh`: pid string, `wait "$pid"`, EXIT trap |
| 13 | Tea house (art) | macOS `caffeinate -w $pid` |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.
