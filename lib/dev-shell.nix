{ actionlint
, elmPackages
, just
, lib
, mkShell

, deploy
, elm2nixPackages
, nodejs
, pnpm

, runPnpmInstall ? true
, enableOptionalDefaultMakefile ? true
, enableOptionalDefaultJustfile ? true
}:

mkShell {
  name = "shell";

  packages = [
    actionlint
    deploy
    elm2nixPackages.elm2nix
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.elm-json
    elmPackages.elm-review
    elmPackages.elm-test
    just
    nodejs
    pnpm
  ];

  shellHook = ''
    export PROJECT_ROOT="$PWD"
    export PATH="$PROJECT_ROOT/node_modules/.bin:$PATH"

    ${lib.optionalString runPnpmInstall ''
      if [ ! -d "$PROJECT_ROOT/node_modules" ]; then
        pnpm install --loglevel warn
      fi
    ''}

    ${lib.optionalString enableOptionalDefaultMakefile ''
      export PROJECT_DEFAULT_MAKEFILE="${./Makefile}"

      if [ ! -f "$PROJECT_ROOT/Makefile" ]; then
        #
        # Learn more: https://www.gnu.org/software/make/manual/html_node/MAKEFILES-Variable.html
        #
        export MAKEFILES="$PROJECT_DEFAULT_MAKEFILE"
      fi
    ''}

    ${lib.optionalString enableOptionalDefaultJustfile ''
      export PROJECT_DEFAULT_JUSTFILE="${./justfile}"

      if [ -z "$(find "$PROJECT_ROOT" -maxdepth 1 \( -iname justfile -o -iname .justfile \))" ]; then
        export JUST_JUSTFILE="$PROJECT_DEFAULT_JUSTFILE"
        export JUST_WORKING_DIRECTORY="$PROJECT_ROOT"
      fi
    ''}
  '';
}
