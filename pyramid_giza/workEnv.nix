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

  pkg-config #for lean http; move to lean-specific env eventually
  libuv #same

  strace
  inotify-tools
    ];
  fromMypkgs = with myPkgs; [ 
    kitties.kitty
    kitties.kittylight
    montezuma_circles_scroll ];
  in
  fromNixpkgs ++ fromMypkgs
