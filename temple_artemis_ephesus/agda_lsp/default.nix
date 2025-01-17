{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "agda_lsp";
  version = "0.2.7.0.1.4";
  src = pkgs.fetchFromGitHub {
    owner = "agda";
    repo = "agda-language-server";
    rev = "acfe0dbda4ade7e7c7b384360a2499e1e79cb984";
    hash = "sha256-BgwucPdO96U16ZWyfcnjaW1NUm/cpoQrnesTsW8ifcE=";
  };

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
  ];

  buildInputs = with pkgs; [
    haskellPackages.stack
    
    #the following are simply needed otherwise the `stack install` command fails
    libtinfo
    libgcc 
    gmp
  ];

  installPhase = ''
    runHook preInstall

    stack build

    runHook postInstall
  '';

}
