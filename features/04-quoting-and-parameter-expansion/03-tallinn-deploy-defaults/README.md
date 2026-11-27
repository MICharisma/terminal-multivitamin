# Quoting and parameter expansion · 03 · Tallinn parcel-locker startup, deploy settings with defaults

A parcel-locker startup in Tallinn deploys to Fly.io from a script that should work with almost no environment set. Defaults fill in the Tallinn region and the replica count, an optional Slack webhook appears only when set, and a missing database URL stops the migration before it starts.

**What it teaches**

- `${var:-default}` uses the default when the variable is unset or empty; `${var-default}` only when unset
- `${var:=default}` also assigns the default, so later lines see it
- `${var:?message}` stops the script with the message when a required setting is missing
- `${var:+value}` gives `value` only when the variable is set, which adds an optional flag to a command
- `VAR=value function` sets a variable for one call only

**Lesson steps**

1. Use a default when the variable is unset or empty (`${var:-default}`)
2. Treat empty differently from unset (`${var-default}`)
3. Assign a default once with := (`${var:=default}`)
4. Add an optional flag only when set (`${var:+value}`)
5. Stop on a missing required setting (`${var:?message}`)

**Files**

| File | Role |
| --- | --- |
| [`deploy_plan.zsh`](deploy_plan.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/04-quoting-and-parameter-expansion/03-tallinn-deploy-defaults/deploy_plan.zsh
tests/run-examples.zsh 03-tallinn-deploy-defaults
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
