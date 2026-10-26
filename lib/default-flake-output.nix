{ mkShell

, build
, devShell
}:

{ name, ... }@args:

let
  site = build args;
in
{
  devShells.default = mkShell {
    inherit name;
    inputsFrom = [ devShell ];
  };

  packages = {
    inherit site;
    default = site;
  };

  apps = {
    inherit (site) serve deploy;
    default = site.serve;
  };

  checks = { inherit site; };
}
