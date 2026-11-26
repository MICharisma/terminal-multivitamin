# Permissions and ownership · 03 · Vienna music university, sharing chamber music scores

A chamber music teacher at a music university in Vienna keeps rehearsal parts for the Schubert "Trout" Quintet and the Brahms Clarinet Quintet, plus a click-track script. Her ensemble's group should read the scores and open the folders, other students should see nothing, and the concert versions should be locked. Each symbolic `chmod` is shown as a before/after diff, so you can see that it changes only the bits it names, and why capital `X` is the right tool for a folder of PDFs.

**What it teaches**

- symbolic modes change only what they name: `o-rwx` leaves the owner and group bits alone
- capital `X` adds execute to folders (and to files already executable), so `g+rX` opens folders without making PDFs executable; lowercase `x` would
- `g=u` copies the owner's bits to the group; `a-w` locks a folder for everyone, owner included
- comma lists apply several clauses in one call: `u=rwx,g=rx,o=`

**Lesson steps**

1. Let the ensemble open folders and read scores (`chmod g+rX`)
2. See why lowercase x is wrong for PDFs (`chmod g+rx`)
3. Remove the others bits and keep everything else (`chmod o-rwx`)
4. Give the group the owner's bits on the click track (`chmod g=u`)
5. Set exact bits with clauses and lock the concert versions (`chmod u=rwx,g=rx,o=`)

**Files**

| File | Role |
| --- | --- |
| [`share_scores.zsh`](share_scores.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/09-permissions-and-ownership/03-vienna-chamber-music-scores/share_scores.zsh
tests/run-examples.zsh 03-vienna-chamber-music-scores
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
