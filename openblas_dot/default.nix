{ pkgs ? import <nixpkgs> {} }:

let pkgs22 = import (builtins.fetchTarball {
        name = "nixos-22.11";
        url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/23.05-beta.tar.gz";
# url = "https://releases.nixos.org/nixos/22.11/nixos-22.11.1580.e285dd0ca97/nixexprs.tar.xz";
#sha256 = "ee65f65849a6d7d9fadeb7f93f37b802";
        sha256 = "1j7g15q2y21bmj709005fqmsb2sriz2jrk1shhnpsj8qys27qws8";
        }) {};
in
with pkgs;

stdenv.mkDerivation {
  name = "hello";

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
      (pkgs22.rustup)
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
    mkdir -p "$out/bin"
    cp ./hello "$out/bin/"
  '';
  shellHook =
  ''
    echo "Hello shell"
    export SOME_API_TOKEN="$(cat ~/.config/some-app/api-token)"
  '';
}
