{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      lib = nixpkgs.lib;
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      eachSupportedSystem = f: lib.foldAttrs lib.mergeAttrs {} (map (s: lib.mapAttrs (_: v: { ${s} = v; }) (f s)) supportedSystems);
    in
    eachSupportedSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          name = "nix-elm-parcel";

          packages = [
            pkgs.nodejs-slim_24
            pkgs.pnpm
          ];

          shellHook = ''
            export PROJECT_ROOT="$PWD"
            export PATH="$PROJECT_ROOT/node_modules/.bin:$PATH"

            if [ ! -d "$PROJECT_ROOT/node_modules" ]; then
              pnpm install --loglevel warn
            fi
          '';
        };
      }
    );
}
