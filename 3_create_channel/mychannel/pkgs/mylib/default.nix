{ pkgs ? import <nixpkgs> {}, }:

let pkgs2305 = import (builtins.fetchTarball {
        name = "nixos-22.11";
        url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/23.05-beta.tar.gz";
        }) {};
in
with pkgs;

stdenv.mkDerivation {
  pname = "mylib";
  version = "0.0.1";

  # Source Code
    src = pkgs.fetchurl {
    url = "https://github.com/t-hishinuma/myhello_pack/releases/download/1.0.0/mylib.tar.gz";
    sha256 = "MgrL8rIcSX9WzjEC5raZStEZNc1uMtqg+VbOT2Gm4w0=";
  };

  # Dependencies
  buildInputs = [ 
      gnumake
      coreutils
      openblas
      gcc
  ];

  configurePhase = ''
    declare -xp
  '';
  buildPhase = ''
      make
  '';
  installPhase = ''
    mkdir -p "$out/lib"
    mkdir -p "$out/include"
    cp ./libmylib.so "$out/lib/"
    cp ./mylib.hpp "$out/include"
    NIX_LDFLAGS="-L~/.nix-profile/lib":$NIX_LDFLAGS
  '';
  shellHook = ''
      set -v
      C_INCLUDE_PATH="$out/include/":$C_INCLUDE_PATH
      LIBRARY_PATH="$out/lib/":$LIBRARY_PATH
      LD_LIBRARY_PATH="$out/lib/":$LD_LIBRARY_PATH
      set +v
  '';
}
