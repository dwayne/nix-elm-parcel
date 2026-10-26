{ mkShell

, build
, devShell
}:

{ name
, devShellArgs ? {}
, ...
}@args:

let
  buildArgs = builtins.removeAttrs args [ "devShellArgs" ];
  site = build buildArgs;
in
{
  devShells.default = mkShell (devShellArgs // {
    inherit name;
    inputsFrom = [ devShell ] ++ (devShellArgs.inputsFrom or []);
  });

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
