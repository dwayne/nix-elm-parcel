{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-utils-src = { url = "github:dwayne/nix-utils"; flake = false; };
    flake-elm2nix = {
      url = "github:dwayne/elm2nix/use-elm-0.19.3";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nix-utils-src.follows = "nix-utils-src";
      };
    };
    flake-deploy = {
      url = "github:dwayne/deploy";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nix-utils-src.follows = "nix-utils-src";
      };
    };
  };

  outputs = { self, nixpkgs, nix-utils-src, flake-elm2nix, flake-deploy }:
    let
      lib = nixpkgs.lib;
      nixUtils = import nix-utils-src lib;
    in
    nixUtils.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };
      in
      {
        #
        # Currently only useful for explorations within `nix repl`.
        #
        # nix-repl> :lf .
        # nix-repl> outputs.legacyPackages.x86_64-linux.DEFAULT_PATHS
        #
        legacyPackages = pkgs.nixElmParcelPackages;
      }
    ) // {
      overlays.default = lib.composeManyExtensions [
        #
        # - elm2nixPackages
        # - elmPackages
        #   - elm
        #   - elm-test
        #
        flake-elm2nix.overlays.default

        #
        # - deploy
        #
        flake-deploy.overlays.default

        #
        # - nixElmParcelPackages
        #
        (final: prev: {
          nixElmParcelPackages = final.callPackage ./lib {};
        })
      ];
    };
}
