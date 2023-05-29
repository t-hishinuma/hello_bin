{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation {
  name = "1_inner_prod";

  # Source Code
  # See: https://nixos.org/nixpkgs/manual/#ssec-unpack-phase
  src = ./.;

  # Dependencies
  # See: https://nixos.org/nixpkgs/manual/#ssec-stdenv-dependencies
  buildInputs = [ 
    python3
    poetry
    zlib
  ];

  # Build Phases
  # See: https://nixos.org/nixpkgs/manual/#sec-stdenv-phases
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
