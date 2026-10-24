{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-utils = { url = "github:dwayne/nix-utils"; flake = false; };
    nix-elm-parcel = { url = ../.; flake = false; };
    flake-elm2nix = {
      url = "github:dwayne/elm2nix/use-elm-0.19.3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-deploy = {
      url = "github:dwayne/deploy";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-utils, nix-elm-parcel, flake-elm2nix, flake-deploy }:
    let
      name = "example";
      hash = "sha256-jtdcqU+04HjTQACEnxoLTrK0QYkRI290AzUb+vU1VR4=";

      lib = nixpkgs.lib;
      nixUtils = import nix-utils lib;
    in
    nixUtils.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ flake-elm2nix.overlays.default ];
        };

        elm2nixLib = flake-elm2nix.lib.mkLib pkgs;
        deploy = flake-deploy.lib.mkDeploy pkgs;

        project = pkgs.callPackage nix-elm-parcel {
          inherit elm2nixLib deploy;
        };

        site = project.build {
          inherit name hash;
          root = ./.;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          inherit name;
          inputsFrom = [ project.devShell ];
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
