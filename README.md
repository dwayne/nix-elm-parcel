# nix-elm-parcel

A development and build environment for [Elm](https://elm-lang.org/) web applications managed with [Nix](https://nixos.org/) and [Parcel](https://parceljs.org/).

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
- Reusable GitHub Actions to [check](./.github/workflows/reusable-checks.yaml) and [deploy](./.github/workflows/reusable-deploy.yaml) your application

## Examples

- [Counter](./example)
- [Elm Todos](https://github.com/dwayne/elm-todos/tree/f903f6024599ffe96c2ce70202c6b262bf8ef08d)
- [Elm Countries Quiz](https://github.com/dwayne/elm-countries-quiz/tree/44c95659f6696d6e7ebd9905f3ae6916f1149acb)

## Quick start

Try the [minimal](./templates/minimal) template.
