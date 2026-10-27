# Environment variables

| Variable name | Description |
|---------------|-------------|
| `PROJECT_ROOT` | The directory in which you ran `nix develop`. |
| `PROJECT_DEFAULT_MAKEFILE` | The default `Makefile` being used by the project. |
| `PROJECT_DEFAULT_JUSTFILE` | The default `justfile` being used by the project. |
| `PROJECT_ELM_JSON_FILES` | The `elm.json` files to lock. (default: `elm.json`) |
| `PROJECT_ELM_DIRS_EXTRA` | Any additional directories, besides `src`, `review`, and `tests`, containing Elm code. (default: empty) |
| `PROJECT_ELM_TEST_RUNNER` | The name of the executable to use to run your Elm tests. (default: `elm-test`) |
| `PROJECT_CLEAN_PATHS_EXTRA` | Any additional paths, besides `.parcel-cache`, `dist`, `elm-stuff`, `node_modules`, and `result`, for `just clean` to remove. (default: empty) |
