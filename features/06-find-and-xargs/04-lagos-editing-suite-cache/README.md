# Finding files with find and xargs · 04 · Lagos film editing suite, clearing the render cache

An editing suite in Surulere, Lagos, is cutting a Nollywood comedy, *Owambe Nights*, and the render cache has filled the drive. The editor wants the big renders and the empty peak file from last night's crash gone, and the empty scene folders with them, while the proxies and the rough cut stay. `-size` and `-empty` pick the files, a `-print` dry run checks the list, and `-delete` does the rest. A throwaway copy shows why `-delete` must come last.

**What it teaches**

- `-size +300k` means "more than 300 KiB" in both BSD and GNU `find`; a `c` suffix counts bytes
- `-empty` matches zero-byte files and folders with nothing in them
- run the expression with `-print` first, and swap in `-delete` once the list looks right
- `-delete` works depth-first, so `-type d -empty -delete` clears nested empty folders in one pass
- `find` reads its expression left to right: `-delete` before `-name` deletes everything it reaches

**Lesson steps**

1. List everything over 300 KiB, keepers included (`find -size`)
2. Dry-run the cache cleanup with -print (`find -empty`)
3. Swap -print for -delete (`find -delete`)
4. Remove nested empty folders in one depth-first pass (`find -type d -empty -delete`)
5. See -delete placed first wipe a whole copy (`find -delete`)

**Files**

| File | Role |
| --- | --- |
| [`clear_cache.zsh`](clear_cache.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/06-find-and-xargs/04-lagos-editing-suite-cache/clear_cache.zsh
tests/run-examples.zsh 04-lagos-editing-suite-cache
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
