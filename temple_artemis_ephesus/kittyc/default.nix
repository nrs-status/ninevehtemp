{ pkgs, ... }:
pkgs.writeScriptBin "kittyc" "${pkgs.lib.getExe pkgs.kitty} -c ${./kitty.conf}"
