{ lib
, newScope
, nodejs-slim_24
, pnpm_12

, deploy
, elm2nixLib
}:

lib.makeScope newScope (self: {
  inherit deploy elm2nixLib;

  build = self.callPackage ./build.nix {};
  devShell = self.callPackage ./dev-shell.nix {};
  mkServe = self.callPackage ./mk-serve.nix {};
  nodejs = nodejs-slim_24;
  pnpm = pnpm_12;
})
