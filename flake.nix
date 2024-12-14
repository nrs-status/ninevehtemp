{
  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvimFlakeInput.url = "github:nix-community/nixvim";
  };

  outputs = { self, nixpkgs, nixvimFlakeInput }:
    let
      # supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      supportedSystems = [ "x86_64-linux" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f rec {
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        inherit system;
        helpers = import ./lighthouse_alexandria { lib = pkgs.lib; };
        myPkgs = helpers.makeMyPkgs { dirpath = ./temple_artemis_ephesus; inherit pkgs; inherit nixvimFlakeInput; inherit system; inherit helpers; };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs, system, myPkgs, helpers}: {
        default = import ./pyramid_giza/workEnvShell.nix { inherit pkgs; inherit myPkgs; inherit system; };
      });
    };
}
