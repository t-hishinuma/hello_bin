{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation {
  name = "2_poetry";
  src = ./.;

  # Dependencies
  buildInputs = [ 
    python3
    poetry
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
