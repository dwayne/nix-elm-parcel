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

  #
  # pnpm settings that every project gets, in the dev shell and in the build.
  #
  # pnpm gives environment variables precedence over pnpm-workspace.yaml, so a
  # project can't override them from its workspace file.
  #
  # Learn more: https://pnpm.io/configuring#environment-variables
  #
  # Elm comes from Nix, so don't install the elm npm package as a peer of
  # @parcel/transformer-elm, and don't warn that it's missing.
  #
  PNPM_ENV = {
    PNPM_CONFIG_AUTO_INSTALL_PEERS = "false";
    PNPM_CONFIG_PEER_DEPENDENCY_RULES = builtins.toJSON {
      ignoreMissing = [ "elm" ];
    };
  };
})
