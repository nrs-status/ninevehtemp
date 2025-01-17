{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  name = "agda_lsp";
  version = "0.2.7.0.1.4";

  src = pkgs.fetchzip {
    url = "https://github.com/agda/agda-language-server/releases/download/v0.2.7.0.1.4/als-Agda-2.7.0.1-ubuntu.zip";
    hash = "sha256-kR9DSAXrccl5qLbNNVutWW5B9NvMR0vCVdT1onUdOlM=";
    stripRoot=false;
  };

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
  ];

  #to determine which packages to put here, I repeatedly 
  buildInputs = with pkgs; [
    zlib
    icu70
    libtinfo
    gmp
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp $src/als $out/bin/als
    chmod +x $out/bin/als

    runHook postInstall
  '';


}
