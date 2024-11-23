{ pkgs, ... }:
let 
  mkKitty = import ./resources/mkKitty.nix { inherit pkgs; };
in
{
  kitty = mkKitty { scriptName = "kittyb"; baseConfPath = ./kitty.conf; themeFileName = "gruvbox-dark.conf"; };
  kittylight = mkKitty { scriptName = "kittyc"; baseConfPath = ./kitty.conf; themeFileName = "gruvbox-light.conf"; };
}
