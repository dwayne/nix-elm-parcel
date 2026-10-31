//
// Elm comes from Nix, so remove the elm peer dependency of
// @parcel/transformer-elm. This only affects @parcel/transformer-elm, so any
// other package's peer dependencies are still auto-installed.
//
// The entry is merged into the project's overrides instead of replacing them,
// so projects can keep setting their own overrides in pnpm-workspace.yaml.
// Their entries win, so a project can even undo this one.
//
export const hooks = {
  updateConfig(config) {
    config.overrides = {
      "@parcel/transformer-elm>elm": "-",
      ...config.overrides,
    };
    return config;
  },
};
