{ pkgs, ... }:
let 
  mkKitty = import ./resources/mkKitty.nix { inherit pkgs; };
in
{
  kitty = mkKitty { scriptName = "kittyb"; baseConfPath = ./kitty.conf; themeFileName = "gruvbox_dark.conf"; };
  kittylight = mkKitty { scripName = "kittyc"; baseConfPath = ./kitty.conf; themeFileName = "gruvbox_light.conf"; };
}
