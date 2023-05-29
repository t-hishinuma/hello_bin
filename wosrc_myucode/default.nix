{ pkgs ? import <nixpkgs> {} }:

let pkgs2305 = import (builtins.fetchTarball {
        name = "nixos-22.11";
        url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/23.05-beta.tar.gz";
#sha256 = "1j7g15q2y21bmj709005fqmsb2sriz2jrk1shhnpsj8qys27qws8";
        }) {};
in
with pkgs;

let tosh_pkgs = import (builtins.fetchTarball {
        name = "tpkg";
        url = "http://127.0.0.1:4545/toshiaki_channel.tar.gz";
#        sha256 = "18kc4km6lqhz06kbr2ada4gp8gy2fk4j0hq7dcy68q53yh2sjl2s";
        }) {};
in
with pkgs;

stdenv.mkDerivation {
  name = "hello";

  # Source Code
  # See: https://nixos.org/nixpkgs/manual/#ssec-unpack-phase
    src = pkgs.fetchurl {
    url = "https://github.com/t-hishinuma/hello_bin/archive/refs/tags/1.0.0.tar.gz";
    sha256 = "5cOmOXOSCpIbNde58voT9jCDV0ZWxSIfJGrZ87aNbtM=";
  };

  # Dependencies
  # See: https://nixos.org/nixpkgs/manual/#ssec-stdenv-dependencies
  buildInputs = [ 
      gnumake
      coreutils
      gcc
      openblas
      zsh
      fftw
      (pkgs2305.rustup)
      (tosh_pkgs.toshi_hello)
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
    cp ./hello_hishinuma "$out/bin/hello"
    mkdir -p "$out/lib"
    cp ./hello_hishinuma "$out/lib/hello"
    cp ./hello_hishinuma "$out/lib/hello"
    ls $out
    hello_hishinuma
  '';

  # nix-shell Hook
  shellHook =
  ''
    echo "Hello shell"
  '';
}
