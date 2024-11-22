{ pkgs, ... }:
{ baseConfPath, themeFileName, scriptName }:
let
  themeString = "include ${pkgs.kitty-themes}/share/kitty-themes/${themeFileName}";
  baseConf = builtins.readFile baseConfPath;
  confToNixStore = pkgs.writeText "kitty.conf" (baseConf + themeString);
in
pkgs.writeScriptBin scriptName "${pkgs.lib.getExe pkgs.kitty} -c ${confToNixStore}"
