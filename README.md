# nix-elm-parcel

Your Elm web application's whole toolchain (Elm 0.19.3, elm-format, elm-review, elm-test, Parcel 2, a production build, CI and deploys) as one versioned dependency, instead of files you copy from project to project.

Your repository holds your app. The tooling lives in this flake, so `nix flake update` upgrades it in every project that uses it.

## Try it

You need [Nix](https://nixos.org/download/) with flakes enabled. You don't need to know Nix.

```bash
nix flake new -t github:dwayne/nix-elm-parcel my-elm-app
cd my-elm-app
git init && git add .
nix develop
just dev
```

Visit http://localhost:1234. `nix develop` gives you every tool at a pinned version and installs your npm dependencies on first run.

## What you get

Run `just` inside `nix develop`:

```
Available recipes:
    dev          # Start the development server [alias: d]
    format       # Format the Elm code in place [alias: f]
    check-format # Check the formatting of the Elm code
    review       # Review the Elm code [alias: r]
    test         # Run the Elm tests [alias: t]
    elm-lint     # Run all Elm code checks
    actionlint   # Lint GitHub Actions workflow files
    lint         # Run all the sanity checks [alias: l]
    verify       # Run all the sanity checks and tests (CI runs this too) [alias: v]
    build        # Build the site for production into ./result [alias: b]
    preview      # Preview the production build locally [alias: p]
    deploy       # Deploy the production build into the deployBranch branch (site by default)
    clean        # Remove build artifacts [alias: c]
```

`just verify` is the same command CI runs, and `just preview` serves the exact files `just deploy` publishes. For CI, two short workflows call this repository's reusable [checks](.github/workflows/reusable-checks.yaml) and [deploy](.github/workflows/reusable-deploy.yaml) workflows. See [Elm Countries Quiz](https://github.com/dwayne/elm-countries-quiz/tree/44c95659f6696d6e7ebd9905f3ae6916f1149acb/.github/workflows) for an example.

## The only configuration you edit

```nix
pkgs.nixElmParcelPackages.defaultFlakeOutput {
  name = "my-elm-app";
  root = ./.;
  hash = "sha256-…"; # Pins your npm dependencies
}
```

The rest of `flake.nix` comes from the template and you can leave it alone.

A real app adds a few lines. Here's [Elm Countries Quiz](https://github.com/dwayne/elm-countries-quiz/blob/44c95659f6696d6e7ebd9905f3ae6916f1149acb/flake.nix):

```nix
pkgs.nixElmParcelPackages.defaultFlakeOutput {
  name = "elm-countries-quiz";
  root = ./.;
  hash = "sha256-…";

  extraPaths = [ ".postcssrc" "tailwind.config.js" ];           # Tailwind via PostCSS
  patches = flake-elm2nix.lib.elmSafeVirtualDomPatches.default; # lydell/elm-safe-virtual-dom
  deployBranch = "gh-pages";                                    # Deploy to GitHub Pages
}
```

## How it's different

- **Tooling is a dependency, not a scaffold.** Project generators copy a Makefile, scripts and CI config into your repository, where they drift. nix-elm-parcel supplies a default `justfile` and `Makefile` when you enter the shell, and only if your project doesn't have its own. Want different recipes? Add a `justfile`.
- **One reproducible build for Elm and npm.** `elm.lock` pins every Elm package by hash, `pnpm-lock.yaml` pins every npm package, and Parcel bundles them in a sandboxed Nix build. Your laptop and CI produce the same site.
- **Patch any Elm package with one line.** Use [`lydell/elm-safe-virtual-dom`](https://github.com/lydell/elm-safe-virtual-dom), or your own fork of a published package, through `patches`. No scripts rewriting `~/.elm`.

## Is it for you?

It's for Elm single-page applications that are bundled with Parcel and served as static files. It's most useful when you want the same tools on every machine and in CI, especially across several apps. It isn't for server-rendered apps, elm-pages or Lamdera.

## Two things to know

Nix mostly stays out of the way, but:

- New files must be tracked by git (`git add`) before `just build` can see them.
- When `pnpm-lock.yaml` changes, update `hash` in `flake.nix`. See [Fix a stale hash](docs/HOWTOs.md#fix-a-stale-hash).

## Features

- Supports Elm 0.19.3
- Supports [`elm-test`](https://github.com/rtfeldman/node-test-runner) and [`elm-test-rs`](https://github.com/mpizenberg/elm-test-rs)
- Supports [`elm-review`](https://github.com/jfmengels/node-elm-review)
- Supports the use of private Elm packages
- Supports the use of [`lydell/elm-safe-virtual-dom`](https://github.com/lydell/elm-safe-virtual-dom), see [Elm Countries Quiz](https://github.com/dwayne/elm-countries-quiz/blob/44c95659f6696d6e7ebd9905f3ae6916f1149acb/flake.nix#L40) for an example
  - In general, you can patch any published Elm package and make use of them in your projects since it is based on [`dwayne/elm2nix`](https://github.com/dwayne/elm2nix)
- Full Parcel 2 support, no limits
- Easily configurable via a small `flake.nix`
- Run common tasks with [Just](https://just.systems/)
- One command, `just deploy`, to deploy your application
- Reusable GitHub Actions to [check](https://github.com/dwayne/nix-elm-parcel/blob/master/.github/workflows/reusable-checks.yaml) and [deploy](https://github.com/dwayne/nix-elm-parcel/blob/master/.github/workflows/reusable-deploy.yaml) your application

## Examples

- [Counter](https://github.com/dwayne/nix-elm-parcel/blob/master/example)
- [Elm Todos](https://github.com/dwayne/elm-todos/tree/f903f6024599ffe96c2ce70202c6b262bf8ef08d)
- [Elm Countries Quiz](https://github.com/dwayne/elm-countries-quiz/tree/44c95659f6696d6e7ebd9905f3ae6916f1149acb)
