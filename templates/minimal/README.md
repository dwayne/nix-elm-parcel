# The minimal template

## Copy the template

Create your project based on the template.

```bash
nix flake new -t github:dwayne/nix-elm-parcel my-elm-app
cd my-elm-app
```

## Make it your own

### Step 1: Rename your project

In [`flake.nix`](./flake.nix) change the `name`:

```nix
pkgs.nixElmParcelPackages.defaultFlakeOutput {
  name = "minimal"; # <--- Change me
  # ...
}
```

### Step 2: Edit LICENSE

In [`LICENSE`](./LICENSE) add `<YEAR>` and `<COPYRIGHT HOLDER>`:

```txt
Copyright <YEAR> <COPYRIGHT HOLDER>

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

...
```

## Commit changes

```
git init
git add .
git commit -m "Initial commit"
```

## Work on it

```bash
nix develop
just dev
```
