{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation {
  name = "1_inner_prod";

  src = ./.;

  # Dependencies
  buildInputs = [ 
      gnumake
      coreutils
      gcc
      openblas
  ];

  # Declare Nix Environment Variables
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
