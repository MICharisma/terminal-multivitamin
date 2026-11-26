# HTTP with curl

Talking to HTTP from the terminal with `curl`: saving bodies, probing headers,
failing loud, sending custom headers and form fields, posting JSON, write-out
metrics, retries, remote-name downloads, following redirects, multipart uploads,
and piping responses through `jq`.

Every scenario stands up a local server on `127.0.0.1` (or uses `file://`) inside
its sandbox. Nothing here reaches the public internet; ephemeral ports never
appear in the printed output.

Official references: `man curl`, `man jq`.

## Examples (13 of 13 built)

01. [Valparaíso Saturday ferry timetable](01-valparaiso-ferry-timetable/) — available
02. [Antananarivo course material headers](02-antananarivo-course-headers/) — available
03. [Penang family laksa recipe](03-penang-family-recipe/) — available
04. [Brno firmware board headers](04-brno-firmware-headers/) — available
05. [Dakar festival ticket form](05-dakar-ticket-form/) — available
06. [Guadalajara mural JSON submission](06-guadalajara-mural-json/) — available
07. [Tromsø aurora forecast timing](07-tromso-aurora-timing/) — available
08. [Colombo tea auction retry](08-colombo-tea-retry/) — available
09. [Stuttgart parts catalog download](09-stuttgart-parts-catalog/) — available
10. [Luanda clinic redirect chain](10-luanda-clinic-redirect/) — available
11. [Da Nang hotel folio upload](11-danang-hotel-upload/) — available
12. [Thessaloniki grade roster with jq](12-thessaloniki-grades-jq/) — available
13. [Hobart release manifest](13-hobart-release-manifest/) — available

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Ferry office (business) | `curl -o` and quiet `-sS` to save a timetable |
| 02 | University desk (education) | `curl -I` / `-sI` to branch on Content-Type |
| 03 | Family kitchen | `curl -fsSL` fails loud on a missing recipe, then fetches |
| 04 | Firmware lab (tech) | `curl -H` in a `for` loop over board revisions |
| 05 | Music festival (music) | `curl -d` and `--data-urlencode` form posts |
| 06 | Mural registry (art) | `curl --json` with fields from an associative array |
| 07 | Observatory (science) | `curl -w` for `http_code`, `content_type`, `size_download` |
| 08 | Tea auction (business) | `curl --retry` against a flaky local server |
| 09 | Machine shop (mechanical) | `curl -O` remote-name downloads into the workdir |
| 10 | Clinic (nonprofit) | `curl -L` follows a 302 intake redirect |
| 11 | Hotel desk (hospitality) | `curl -F` multipart folio upload |
| 12 | Conservatory (education) | `jq` / `jq -r` over a JSON grade roster |
| 13 | Release desk (tech) | Capstone: `-fsSL`, `-H`, `-w`, and `jq` on one manifest |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.
