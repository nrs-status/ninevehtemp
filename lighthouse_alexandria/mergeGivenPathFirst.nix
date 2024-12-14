{ pkgs, helpers }:
nestedAttrsPathAsList: attrsA: attrsB:
  let
  nestedAttrsFromA = pkgs.lib.attrset.attrByPath nestedAttsPathAsList
