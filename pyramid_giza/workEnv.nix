{ pkgs, myPkgs }:
  let
  fromNixpkgs = with pkgs; [
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
  fromMypkgs = with myPkgs; [ 
    kitty
    montezuma_circles_scroll ];
  in
  fromNixpkgs ++ fromMypkgs
