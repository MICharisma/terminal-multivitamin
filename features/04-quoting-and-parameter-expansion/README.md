# Quoting and parameter expansion

How the shell decides what a word means. Quotes turn off special characters;
parameter expansion (`$var`, `${...}`) pulls values in. This feature covers
single vs double quotes, ANSI-C quoting (`$'...'`), the
`${var:-default}` / `${var:=default}` / `${var:?message}` / `${var:+value}`
family, prefix and suffix removal, slicing and replacement, zsh flags
(`(C)` `(U)` `(q)` `(s:,:)` `(j:,:)` `(P)` `(e)` `(%)`), arrays and associative
arrays, and the bash / POSIX `sh` rules that differ from zsh. One slot is written
in bash, one in POSIX `sh`, and one needs macOS (`say`, `osascript`).

zsh vs bash vs POSIX `sh` at a glance:

| Idea | zsh | bash | POSIX `sh` |
| --- | --- | --- | --- |
| Unquoted `$var` with spaces | stays one word | splits on `$IFS` and globs | splits and globs |
| Arrays | `$arr[1]`, `"${arr[@]}"` | `"${arr[@]}"` (1-based in zsh, 0-based in bash) | no arrays; use `set --` |
| Uppercase | `${(U)name}` | `${name^^}` (bash 4+) | `tr '[:lower:]' '[:upper:]'` |
| Indirect expansion | `${(P)name}` | `${!name}` | `eval` (careful) |
| Defaults | `${var:-d}` `${var:=d}` `${var:?m}` `${var:+v}` | same | same |
| ANSI-C quotes | `$'\\t'` | `$'\\t'` | not in POSIX; use `printf` |

Never assign to `$path` in zsh: it is tied to `$PATH`, and a string assignment
wipes the executable search path.

Official references: `man zshexpn` ("Parameter Expansion", "Quoting"),
`man zshparam` (arrays), `man bash` ("Quoting", "Parameter Expansion").

## Examples (13 of 13 built)

01. [Hong Kong dim sum teahouse, printing the menu board](01-hong-kong-dim-sum-menu/) — available
02. [Montréal theatre, building the surtitle cue file](02-montreal-theatre-surtitles/) — available
03. [Tallinn parcel-locker startup, deploy settings with defaults](03-tallinn-deploy-defaults/) — available
04. [Rotterdam container terminal, decoding manifest file names](04-rotterdam-container-codes/) — available
05. [Athens family wedding, place cards from the aunts' guest list](05-athens-wedding-place-cards/) — available
06. [Kuala Lumpur secondary school, splitting the timetable](06-kuala-lumpur-school-timetable/) — available
07. [Havana son septet, who plays tonight](07-havana-son-septet-setlist/) — available
08. [Dakar fishing cooperative, tallying the morning landing](08-dakar-fishing-cooperative/) — available
09. [Florence conservation lab scan names, in bash](09-florence-conservation-scans/) — available
10. [Gdańsk shipyard weld inspections, in portable sh](10-gdansk-shipyard-welds/) — available
11. [Antananarivo family photo archive, quoting the filenames](11-antananarivo-family-photos/) — available
12. [Brisbane jazz club, announcing the next set](12-brisbane-jazz-set-announce/) — available, macOS only
13. [Amman fintech ops, resolving nested deploy config](13-amman-fintech-config/) — available

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Teahouse (business) | Single vs double quotes, `\$`, joined quote pieces, apostrophes |
| 02 | Theatre (art) | `$'\\t'` `$'\\n'`, UTF-8 bytes under `LC_ALL=C` |
| 03 | Startup (tech) | `${var:-}` `${var-}` `${var:=}` `${var:+}` `${var:?}` |
| 04 | Port (mechanical) | `${##}` `${%}` `${%%}` slicing `${:offset:len}` `${/}` `${//}` |
| 05 | Family wedding | `(C)` `(U)` `(L)` `(r:…::.:)` and quoted nested arrays |
| 06 | Secondary school (education) | `(f)` `(s:,:)` `"${(@s:,:)}"` `(j:)` `(F)` |
| 07 | Son septet (music) | Arrays: index, slice, `+=`, `(i)` `(r)`, `:|` `:*`, `"${arr[@]}"` |
| 08 | Fishing cooperative (business) | `typeset -A`, `(kv)` `(ok)`, `${+key}`, reverse lookup |
| 09 | Conservation lab (art) | bash: unquoted split/glob, `"$@"`, `printf %q`, `${^^}` |
| 10 | Shipyard (mechanical) | POSIX `sh`: `set -f`, `IFS=:` `set --`, trims, `"$*"` |
| 11 | Family | `(q)` `(qq)` `(qqq)` `(Q)`, `"${(@q)arr}"` |
| 12 | Jazz club (music) | macOS `say`/`osascript` with `(q)` `(qq)` and escaped quotes |
| 13 | Fintech (tech) | Capstone: `(P)` `(e)` stacked trims, `:h` `:t`, `(%)`, never `$path` |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.
