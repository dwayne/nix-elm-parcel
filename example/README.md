# Example

A simple example to sanity check the **nix-elm-parcel** Nix library.

## Things to check

Check that you can start the development server.

```bash
cd example
nix develop
just dev
```

Visit http://localhost:1234 in your browser.

Check that you can format the Elm files.

```bash
just format
```

Check that the lints pass.

```bash
just lint
```

Check that the tests pass.

```bash
just test
```

Check that you can remove the build artifacts.

```bash
just clean
```

Check that you can build the site.

```bash
just build
```

Inspect the site's files in the `result` directory.

Preview the site.

```bash
just preview
```

Visit http://localhost:8000 in your browser.
