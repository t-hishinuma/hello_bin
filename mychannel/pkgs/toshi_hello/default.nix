{ pkgs ? import <nixpkgs> {} }:

let pkgs2305 = import (builtins.fetchTarball {
        name = "nixos-22.11";
        url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/23.05-beta.tar.gz";
#sha256 = "1j7g15q2y21bmj709005fqmsb2sriz2jrk1shhnpsj8qys27qws8";
        }) {};
in
with pkgs;

let toshi_pkgs = import (builtins.fetchTarball {
        name = "tpkg";
        url = "http://127.0.0.1:4545/toshiaki_channel.tar.gz";
#sha256 = "19nih3p0shnz22r7m4qim1a32dbipkkc9vb24idkxfkxnjgq27bh";
        }) {};
in
with pkgs;

stdenv.mkDerivation {
  name = "toshi_hello";

  # Source Code
  # See: https://nixos.org/nixpkgs/manual/#ssec-unpack-phase
    src = pkgs.fetchurl {
    url = "https://github.com/t-hishinuma/hello_bin/archive/refs/tags/1.0.0.tar.gz";
    sha256 = "5cOmOXOSCpIbNde58voT9jCDV0ZWxSIfJGrZ87aNbtM=";
  };

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
    cp ./hello_hishinuma "$out/bin/"
  '';

  # nix-shell Hook
  shellHook =
  ''
    echo "Hello shell"
  '';
}
