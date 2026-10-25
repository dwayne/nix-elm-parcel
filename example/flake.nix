{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-utils-src = { url = "github:dwayne/nix-utils"; flake = false; };
    flake-nix-elm-parcel = {
      url = ../.;
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nix-utils-src.follows = "nix-utils-src";
      };
    };
  };

  outputs = { self, nixpkgs, nix-utils-src, flake-nix-elm-parcel }:
    let
      name = "example";
      hash = "sha256-jtdcqU+04HjTQACEnxoLTrK0QYkRI290AzUb+vU1VR4=";

      lib = nixpkgs.lib;
      nixUtils = import nix-utils-src lib;
    in
    nixUtils.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ flake-nix-elm-parcel.overlays.default ];
        };

        site = pkgs.nixElmParcelPackages.build {
          inherit name hash;
          root = ./.;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          inherit name;
          inputsFrom = [ pkgs.nixElmParcelPackages.devShell ];
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
    );
}
