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
      lib = nixpkgs.lib;
      nixUtils = import nix-utils-src lib;
    in
    nixUtils.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ flake-nix-elm-parcel.overlays.default ];
        };
      in
      pkgs.nixElmParcelPackages.defaultFlakeOutput {
        name = "example";
        root = ./.;
        hash = "sha256-Iw+oY4nDXVkvjfhrThW/UCtuttP69vZSsPkhnCbEwms=";
      }
    );
}
