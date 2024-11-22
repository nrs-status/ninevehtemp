{ pkgs, ... }:
pkgs.writeScriptBin "kitty" "${pkgs.lib.getExe pkgs.kitty} -c ${./kitty.conf}"
