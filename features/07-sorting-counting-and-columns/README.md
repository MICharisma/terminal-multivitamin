# Sorting, counting, and columns

Shell tools that turn lines into sorted keys, tallies, merged tables, and aligned columns:
`sort` and `uniq`, `cut`, `join`, `comm`, `paste`, `tr`, `column`, `wc`, and macOS `rs`.
The slots build from simple counts up to outer joins and book-layout grids, and point out
places BSD and GNU pad counts or disagree on flags.

| Task | macOS (BSD) | Linux (GNU) | Portable |
| --- | --- | --- | --- |
| Count duplicates | `uniq -c` pads counts | same idea, different padding | `sort \| uniq -c`, read two fields |
| Sort keys | `sort -k1,1n` | same | `LC_ALL=C`, explicit `-kstart,stop` |
| Drop one `cut` field | no `--complement` | `cut --complement` | `cut -f1,3-` |
| `join` separator | `join -t,` | same | sort inputs on join field first |
| `comm` columns | `-23` only file 1 | same | both files sorted |
| `wc -l` in scripts | pads with spaces | usually tight | `$(( $(wc -l < f) ))` |
| `column -t` | BSD `column` | util-linux extras | `-t -s $'\t'` for TSV |
| Reshape lines | `rs` built in | often missing | macOS-only slot |

Habits that hold on both: run `sort` before `uniq` or `join`, sort both sides before
`comm`, name delimiters with `join -t` and `sort -t`, and read `uniq -c` counts with
`read -r count item` instead of fixed-width `printf`.

## Examples (13 of 13 built)

01. [Lisbon pastelaria, tallying the 23 December orders](01-lisbon-pastelaria-tally/) — available
02. [Addis Ababa running club, sorting the Entoto time trial](02-addis-ababa-time-trial/) — available
03. [Turin classic car workshop, cutting columns from a parts catalogue](03-turin-restoration-parts/) — available
04. [Phnom Penh silk cooperative, matching weavers to dye lots](04-phnom-penh-silk-cooperative/) — available
05. [Bangkok street food, cleaning the vendor sign board](05-bangkok-street-food/) — available
06. [Dhaka garment packing, lining up carton labels](06-dhaka-garment-packing/) — available
07. [Amman architecture studio, tabulating facade heights](07-amman-architecture-studio/) — available
08. [Oslo museum accession, reconciling photo day with the register](08-oslo-museum-accession/) — available
09. [Riga city library, auditing holds against the patron directory](09-riga-city-library-holds/) — available
10. [Porto wine lodge, measuring the tasting notes sheet](10-porto-wine-lodge/) — available
11. [Jaipur puppet theatre, counting cues for the night show](11-jaipur-puppet-theatre/) — available
12. [Kampala boda-boda fare desk, tallying popular routes](12-kampala-boda-boda-fare-desk/) — available
13. [Kyoto calligraphy school, reflowing a practice stroke grid](13-kyoto-calligraphy-school/) — available, macOS only

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Pastelaria (hospitality) | `uniq -c` needs `sort`, tie-break keys `-k1,1nr -k2,2` |
| 02 | Running club (education) | `sort -t, -k4,4n`, `-k3` vs `-k3,3`, per-key reverse |
| 03 | Car workshop (mechanical) | `cut -c`, `cut -f`, `-s`, no field reorder, `-f1,3-` |
| 04 | Silk cooperative (nonprofit) | `join -t,`, sorted join field, unsorted join failure |
| 05 | Street food (hospitality) | `tr` downcase, `-d`, `-s`, complement `-c` |
| 06 | Garment factory (business) | `paste`, `paste -d`, `paste -s` |
| 07 | Architecture studio (art) | `column -t`, `-s` for TSV, function wrapper |
| 08 | Museum (government) | `comm -23`, `-13`, `-12` on sorted id lists |
| 09 | City library (education) | inner `join`, outer via `-v1`/`-v2`, no GNU `-o auto` |
| 10 | Wine lodge (hospitality) | `wc -l/-w/-c`, `wc -L`, arithmetic line counts |
| 11 | Puppet theatre (art) | bash `sort \| uniq -c`, process-substitution array (bash 3.2) |
| 12 | Boda stand (business) | POSIX `sh`: `cut`, `sort`, `uniq -c` route tallies |
| 13 | Calligraphy school (art, education) | macOS BSD `rs -e` reshape for practice grids |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.