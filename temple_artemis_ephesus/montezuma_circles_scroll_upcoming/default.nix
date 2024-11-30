{ pkgs, nixvimFlakeInput, system, ...}:
  let
  mkNixvim = import ./resources/mkNixvim.nix { inherit pkgs; inherit nixvimFlakeInput; inherit system; };
  onlyLeanAttrs = {
    plugins = import ./resources/plugins/leanPlugin.nix {inherit pkgs;};
    filetype = {};
    extraPlugins = [];
    extraConfigLua = builtins.readFile ./resources/extraConfigLua/leanLspStartAutoCmd.lua;
    packagesApartFromNixvim = with pkgs; [ elan ];
  };
in
{
  onlyLean = (mkNixvim onlyLeanAttrs).result;
}
