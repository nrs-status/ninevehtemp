{ pkgs, ...}:
let
  exts = import ./extensions.nix { inherit pkgs; };
in
  pkgs.vscode-with-extensions.override {
    vscodeExtensions = exts;
  }
