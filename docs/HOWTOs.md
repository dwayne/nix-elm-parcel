# HOWTOs

## Fix a stale hash

If you see `ERR_PNPM_NO_OFFLINE_TARBALL` it means you have a stale hash. This happens whenever your npm dependencies, `pnpm-lock.yaml`, change. You will need to do the following to fix it:

1. Set `hash` to "" (empty string).
2. Build the derivation, `just build`, and wait for it to fail with a hash mismatch.
3. Copy the 'got: sha256-' value back into the `hash` field.

## Fix a path does not exist error

```
error: lib.fileset.unions: Element 0 (.../public) is a path that does not exist.
  To create a file set from a path that may not exist, use `lib.fileset.maybeMissing`.
```

New paths must be tracked by `git` for Nix to see them. Usually staging the path resolves the problem. For e.g.

```bash
git add public
```
