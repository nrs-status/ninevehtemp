let
  pkgs = import <nixpkgs> {};
  nixvimFlakeInput = builtins.getFlake "github:nix-community/nixvim";
  system = "x86_64-linux";
in
  import ./default.nix { inherit pkgs; inherit nixvimFlakeInput; inherit system; }
