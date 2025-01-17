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
    nixpkgs2.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvimFlakeInput2.url = "github:nix-community/nixvim";
  };

  outputs = { self, nixpkgs, nixpkgs2, nixvimFlakeInput, nixvimFlakeInput2 }:
    let
      # supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      supportedSystems = [ "x86_64-linux" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f rec {
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        pkgs2 = import nixpkgs2 { inherit system; config.allowUnfree = true; };
        inherit system;
        helpers = import ./lighthouse_alexandria { lib = pkgs.lib; };
        myPkgs = helpers.makeMyPkgs { dirpath = ./temple_artemis_ephesus; inherit pkgs; inherit nixvimFlakeInput; inherit system; inherit helpers; };
        myPkgs2 = helpers.makeMyPkgs { dirpath = ./temple_artemis_ephesus; pkgs = pkgs2; nixvimFlakeInput = nixvimFlakeInput2; inherit system; inherit helpers; };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs, pkgs2, system, myPkgs, myPkgs2, helpers}: {
        default = import ./pyramid_giza/workEnv.nix { inherit pkgs; inherit system; inherit myPkgs; inherit helpers; };
        coqEnv = import ./pyramid_giza/coqEnv.nix { inherit pkgs; inherit system; inherit myPkgs; inherit helpers; };
        agdaEnv = import ./pyramid_giza/agdaEnv.nix { pkgs = pkgs2 ; inherit system; myPkgs = myPkgs2; inherit helpers; };
      });

      apps = forEachSupportedSystem ({ pkgs, pkgs2, system, myPkgs, myPkgs2, helpers}: {
        vscode = {
          type = "app";
          program = "${myPkgs2.vscode}";
        };
      }); 
    };
}
