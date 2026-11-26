# Globbing and expansion

Filename generation: the shell turns a pattern into the list of files that match it
before the command runs. This feature covers basic wildcards (`*`, `?`, `[...]`),
brace expansion (which invents words and doesn't look at files at all), zsh's
recursive `**/`, glob qualifiers (`(.)`, `(/)`, `(L+n)`, `(m-n)`, `(om)`, `(N)`),
extended globs (`^`, `~`, `(a|b)`, `<n-m>`, `(#i)`), path modifiers (`:t :h :r :e :s`),
no-match handling, and `zmv`. Two slots switch shells on purpose, to show the same
ideas in bash (`extglob`) and in portable POSIX `sh`.

zsh vs bash at a glance:

| Idea | zsh | bash |
| --- | --- | --- |
| Recursive glob | `**/*.ly` (always on) | `shopt -s globstar` (bash 4+, not macOS's bash 3.2) |
| No match | error by default; `(N)` or `setopt null_glob` | literal pattern by default; `shopt -s nullglob` |
| Negation | `^*.cr3` (`extended_glob`) | `!(*.cr3)` (`shopt -s extglob`) |
| Alternation | `(jpg\|png)` | `@(jpg\|png)` (`extglob`) |
| Case-insensitive | `(#i)*.jpg` | `shopt -s nocaseglob` |
| Filter by type, size, time | qualifiers: `*(.)`, `*(Lk+100)`, `*(m-7)` | use `find` |
| Number ranges | `<120-135>` | none (use `case` or `find`) |

Official references: `man zshexpn` ("Filename Generation", "Brace Expansion",
"Modifiers"), `man zshcontrib` (`zmv`), and `man bash` ("Pattern Matching").

## Examples (13 of 13 built)

01. [Nairobi Coffee Exchange auction catalogue](01-nairobi-coffee-auction/) — available
02. [Cusco Quechua language school course folders](02-cusco-quechua-school/) — available
03. [Glasgow pipe band repertoire scores](03-glasgow-pipe-band/) — available
04. [Quezon City family balikbayan box lists](04-manila-balikbayan-box/) — available
05. [Bergen weather radar archive, sizing the sweeps](05-bergen-radar-archive/) — available
06. [Chennai textile export house, this week's purchase orders](06-chennai-textile-export/) — available
07. [Ljubljana beekeeping cooperative label photos](07-ljubljana-honey-labels/) — available
08. [Santiago mine maintenance office, haul truck telemetry](08-santiago-haul-trucks/) — available
09. [Yogyakarta batik studio, naming web images from scans](09-yogyakarta-batik-scans/) — available
10. [Cairo University Egyptology field season, daily reports](10-cairo-field-reports/) — available
11. [Zanzibar reef survey photos, in bash](11-zanzibar-reef-survey/) — available
12. [Wellington Cable Car brake logs, in portable sh](12-wellington-cable-car/) — available
13. [Seoul webtoon studio, renumbering exported panels](13-seoul-webtoon-studio/) — available

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Commodity exchange (business) | `*`, `?`, character sets, negated sets, quoting |
| 02 | Language school (education) | Brace expansion: lists, padded and stepped sequences, braces vs globs |
| 03 | Pipe band (music) | Recursive `**/`, anchored recursive patterns, `***/` through symlinks |
| 04 | Family | Type qualifiers `(.)` `(/)` `(@)` `(-/)`, `(/^F)`, `(N)`, `${~pattern}` |
| 05 | Weather radar (tech, science) | Size qualifiers, sort-and-slice `(OL[1,3])`, stacked and negated qualifiers |
| 06 | Textile exporter (business) | Time qualifiers `(m-7)` `(mh-24)` `(m+30)` `(om[1])`, `strftime` |
| 07 | Beekeeping cooperative (business, art) | Scoped `extended_glob`, `^`, `~`, alternation |
| 08 | Copper mine (mechanical) | Number ranges `<n-m>`, `(n)` numeric sort, `(#i)` |
| 09 | Batik studio (art) | Modifiers `:t :h :r :e :s`, modifiers in qualifiers, `(u)` |
| 10 | University dig (education) | `nomatch` vs `null_glob` vs `(N)`, empty-array checks |
| 11 | Reef conservation (science, nonprofit) | bash `extglob`, `nocaseglob`, `nullglob`, bash 3.2 empty arrays |
| 12 | Cable car (mechanical) | POSIX `sh`: guarded loops, `set --` counts, `case` patterns |
| 13 | Webtoon studio (art, tech) | `zmv`: captures, padding, `-n` dry run, collision refusal, `-W` |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.
