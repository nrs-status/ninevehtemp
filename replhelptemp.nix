let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  helpers = import ./lighthouse_alexandria { inherit lib; };
in
rec {
  inherit pkgs;
  inherit lib;
  inherit helpers;
  mypkgs = helpers.makeMyPkgs { dirpath = ./temple_artemis_ephesus; inherit pkgs; system = "x86_64-linux"; inherit helpers; nixvimFlakeInput = builtins.getFlake "github:nix-community/nixvim"; };
  kitty = mypkgs.kitty;
}
