{ pkgs, ... }:
let 
  kittyBaseConf = builtins.readFile ./kitty.conf;
  confExtension = import ./toIncludeInConf.nix { inherit pkgs; };
  totalConf = kittyBaseConf + confExtension;
  asNixStoreFile = pkgs.writeText "kitty.conf" totalConf;
in
pkgs.writeScriptBin "kittyb" "${pkgs.lib.getExe pkgs.kitty} -c ${asNixStoreFile}"
