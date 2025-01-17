{ pkgs, system, myPkgs, helpers }:
let
  generalPackages = with pkgs; [
    nix-index #allows finding what packages provide dependencies for auto-patchelf
    git
    ripgrep
    bat
    eza
    jq
    fzf

    elan

    strace
    inotify-tools
  ];
  fromMyPkgs = with myPkgs; [
    kitties.kitty
    kitties.kittylight
    montezuma_circles_scroll_upcoming.leanEnv
  ];
in
pkgs.mkShell {
    packages = generalPackages ++ fromMyPkgs;

    SUDO_EDITOR = pkgs.lib.getExe myPkgs.montezuma_circles_scroll_upcoming.leanEnv;

    shellHook = ''
    export name=mainenvshell

    echo "loading lean systools build; temporary solution until I have time to package it properly"

    export PATH=$PATH:/home/seba/app/newFramework/systools/.lake/build/bin
    '';
}

