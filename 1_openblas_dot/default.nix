{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation {
  name = "1_inner_prod";

  src = ./.;

  # Dependencies
  buildInputs = [ 
      gnumake
      coreutils
      openblas
      gcc
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
}


# Many phases exsist. Each phase can be overridden
# prePhases
# unpackPhase
# patchPhase
# preConfigurePhases
# configurePhase
# preBuildPhases 
# buildPhase 
# checkPhase
# preInstallPhases
# installPhase
# fixupPhase
# installCheckPhase
# preDistPhases
# distPhase
# postPhases

# and shell hook (I will use this 2nd example)
