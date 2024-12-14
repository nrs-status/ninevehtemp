{ pkgs }:
targetPathAsList: attrs:
pkgs.lib.updateManyAttrsByPath
[
  {
	path = pkgs.lib.init targetPathAsList;
	update = old: pkgs.lib.filterAttrs (name: val: (lib.last.targetPathAsList)) old;
  }
]
attrs
