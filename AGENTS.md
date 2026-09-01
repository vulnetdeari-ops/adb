# This folder is the method factory

Not a product app. Cursor and GitHub look here for `AGENTS.md`. The living product rules are **[Rules/AGENTS.md](Rules/AGENTS.md)** — follow that file.

Never run Start against this folder. Never write `METHOD.md`, `OWNER.md`, or `LESEN.html` here.

To put the method into an app:

```bash
./Methods/ADB/setup-into-project.sh --plain /path/to/app   # small
./Methods/ADB/setup-into-project.sh /path/to/app            # large (ADB)
```

Setup copies `Rules/AGENTS.md` into the **app** as `AGENTS.md`. Until that runs, an app such as PinnwandTest has no `AGENTS.md`. `--refresh` copies from this clone; it does not fetch GitHub by itself. `git pull` here first.
