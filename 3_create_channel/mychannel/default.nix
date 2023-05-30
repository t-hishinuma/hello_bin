{system ? builtins.currentSystem}: let
  pkgs = import <nixpkgs> {inherit system;};

  callPackage = pkgs.lib.callPackageWith (pkgs // self);

  self = {
    mylib = callPackage ./pkgs/mylib { };
  };
in
  self
