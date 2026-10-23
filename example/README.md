# Example

A simple example to sanity check the nix-elm-parcel Nix library.

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

Check that linting passes.

```bash
just lint
```

Check that you can remove the build artifacts.

```bash
just clean
```

Check that you can build the site.

```bash
make site
```

Inspect the site's files in the `result` directory.

Check that you can serve the site.

```bash
make serve
```

Visit http://localhost:8000 in your browser.
