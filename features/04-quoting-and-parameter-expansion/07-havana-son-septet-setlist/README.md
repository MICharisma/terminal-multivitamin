# Quoting and parameter expansion · 07 · Havana son septet, who plays tonight

A son septet in Centro Habana keeps its lineup in a zsh array: tres, voz, trompeta, bongó. One player is sick, a guest sits in on timbales, and the set list has to print as one word per song. Indexes, slices, search, set operations, and `"${array[@]}"` vs `"$array"` cover the night.

**What it teaches**

- zsh arrays start at 1: `$band[1]` is the first element, `$band[-1]` the last, `$band[2,4]` a slice
- `${#band}` counts elements; `band+=( ... )` appends; `band[2]=()` removes an element
- `${band[(i)pattern]}` finds the index of the first match; `${band[(r)pattern]}` the value
- `${band:|absent}` keeps elements not in `absent`; `${tonight:*regulars}` keeps those in both
- `"${band[@]}"` passes one word per element; `"$band"` (or `"${band[*]}"`) passes one joined word

**Lesson steps**

1. Read by index and slice (`$array[2,4]`)
2. Append a guest and remove a sick player (`array+=(...)`)
3. Find a player by instrument (`${array[(i)pattern]}`)
4. Subtract absences and intersect with regulars (`${a:|b}`)
5. Pass one word per element with "${array[@]}" (`"${array[@]}"`)

**Files**

| File | Role |
| --- | --- |
| [`septet_setlist.zsh`](septet_setlist.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/04-quoting-and-parameter-expansion/07-havana-son-septet-setlist/septet_setlist.zsh
tests/run-examples.zsh 07-havana-son-septet-setlist
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
