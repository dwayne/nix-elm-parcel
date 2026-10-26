{ lib
, newScope
, nodejs-slim_24
, pnpm_12

, deploy
, elm2nixPackages
}:

lib.makeScope newScope (self: {
  inherit deploy elm2nixPackages;

  devShell = self.callPackage ./dev-shell.nix {};

  build = self.callPackage ./build.nix {};
  mkServe = self.callPackage ./mk-serve.nix {};
  nodejs = nodejs-slim_24;
  pnpm = pnpm_12;

  defaultFlakeOutput = self.callPackage ./default-flake-output.nix {};

  # Constants

  DEFAULT_PATHS =
    [
      "public"
      "src"
      ".parcelrc"
      "elm.json"
      "package.json"
      "pnpm-lock.yaml"
      "pnpm-workspace.yaml"
    ];

  OPTIONAL_PATHS =
    [
      "public"
      ".parcelrc"
    ];
})
