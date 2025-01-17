{ pkgs, system, myPkgs, helpers }:
let
  generalPackages = with pkgs; [
    git
    ripgrep
    bat
    eza
  ];
  fromMyPkgs = with myPkgs; [
    kitties.kitty
    kitties.kittylight
    montezuma_circles_scroll_upcoming.coqEnv
  ];
in
pkgs.mkShell {
    packages = generalPackages ++ fromMyPkgs;

    SUDO_EDITOR = pkgs.lib.getExe myPkgs.montezuma_circles_scroll_upcoming.coqEnv;

    shellHook = ''
    export name=mainenvshell

    echo "loading lean systools build; temporary solution until I have time to package it properly"

    export PATH=$PATH:/home/seba/app/newFramework/systools/.lake/build/bin
    '';
}

