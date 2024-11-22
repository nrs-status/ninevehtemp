{ pkgs, ... }:
pkgs.writeScriptBin "kittyb" "${pkgs.lib.getExe pkgs.kitty} -c ${./kitty.conf}"
