{ pkgs ? import <nixpkgs> {} }:

let pkgs2205 = import (builtins.fetchTarball {
        name = "nixos-22.05";
        url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/22.05.tar.gz";
        }) {};
in
let pkgs2305 = import (builtins.fetchTarball {
        name = "nixos-23.05";
        url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/23.05-beta.tar.gz";
        }) {};
in
with pkgs;

stdenv.mkDerivation {
  name = "2_poetry";
  src = ./.;

  # Dependencies
  buildInputs = [ 
    pkgs2305.python3
    pkgs2205.poetry
    zlib
  ];

  # Declare Nix Environment Variables
  configurePhase = ''
    declare -xp
  '';
  buildPhase = ''
      echo "noting to build"
  '';
  installPhase = ''
      echo "noting to install"
  '';

  # nix-shell Hook
  shellHook =
  ''
    rm -rf .venv
    # zlib path
    export LD_LIBRARY_PATH=$(nix --extra-experimental-features nix-command eval --impure --raw --expr 'with import <nixpkgs> {}; zlib')/lib:$LD_LIBRARY_PATH
    poetry install
  '';
}
