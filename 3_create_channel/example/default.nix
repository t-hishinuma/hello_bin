{ pkgs ? import <nixpkgs> {} }:

let pkgs2305 = import (builtins.fetchTarball {
        name = "nixos-23.05";
        url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/23.05-beta.tar.gz";
        }) {};
in
let mypkgs = import (builtins.fetchTarball {
        name = "mypkg";
        url = "https://github.com/t-hishinuma/myhello_pack/releases/download/1.0.0/mychannel.tar.gz";
        }) {};
in
with pkgs;

stdenv.mkDerivation {
  name = "mychannel_example";

  src = ./.;

  nativeBuildInputs = [ 
      (mypkgs.mylib)
  ];

  buildInputs = [ 
      gnumake
      coreutils
      (pkgs2305.gcc)
      (pkgs2305.openblas)
  ];

  # Build Phases
  configurePhase = ''
      declare -xp
      '';
  buildPhase = ''
      g++ ./inner_prod.cpp $NIX_CFLAGS_COMPILE -L$nativeBuildInputs/lib/ -o sample2 -fopenmp -lmylib -lopenblas
      '';
  installPhase = ''
      mkdir -p $out/bin/
      cp ./sample2 $out/bin/
      '';

  shellHook =
      ''
# nothing to do
      '';
}
#    export LD_LIBRARY_PATH=$(nix --extra-experimental-features nix-command eval --impure --raw --expr 'with import <nixpkgs> {}; zlib')/lib:$LD_LIBRARY_PATH
#LD_LIBRARY_PATH=$(nix eval pkgs2305.gcc.outPath):$LD_LIBRARY_PATH
#      echo $LD_LIBRARY_PATH
