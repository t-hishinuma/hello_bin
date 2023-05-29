{system ? builtins.currentSystem}: let
  pkgs = import <nixpkgs> {inherit system;};

  callPackage = pkgs.lib.callPackageWith (pkgs // self);

  self = {
    toshi_hello = callPackage ./pkgs/toshi_hello { };
  };
in
  self
