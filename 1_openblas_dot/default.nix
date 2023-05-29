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
      gnumake
      coreutils
      gcc
      openblas
  ];

  # Build Phases
  # See: https://nixos.org/nixpkgs/manual/#sec-stdenv-phases
  configurePhase = ''
    declare -xp
  '';
  buildPhase = ''
      make
  '';
  installPhase = ''
      mkdir -p $out/bin/
      cp ./sample1 $out/bin/
  '';

  # nix-shell Hook
  shellHook =
  ''
    echo "Hello shell"
  '';
}
