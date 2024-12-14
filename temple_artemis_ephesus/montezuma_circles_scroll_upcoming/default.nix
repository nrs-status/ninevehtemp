{ pkgs, nixvimFlakeInput, system, ...}:
  let
  mkNixvim = import ./resources/mkNixvim.nix { inherit pkgs; inherit nixvimFlakeInput; inherit system; };
  leanEnvAttrs = {
    plugins = import ./resources/plugins/leanPlugin.nix {inherit pkgs;};
    filetype = {};
    extraPlugins = [];
    extraConfigLua = builtins.readFile ./resources/extraConfigLua/leanLspStartAutoCmd.lua;
    packagesApartFromNixvim = with pkgs; [ elan ];
  };
  workEnvAttrs = pkgs.lib.attrsets.updateManyAttrsByPath
  [
    {
      path = [ "plugins" ];
        update = old: let
    webdevPlugins = import ./resources/plugins/webdevPlugins.nix;
    in
      old;
    }
    {
      path = [ "packagesApartFromNixvim" ];
      update = old: old ++ (with pkgs; [ prettierd rustywind styelint htmlbeautifier ]);
    }
  ]
  leanEnvAttrs;
in
{
  leanEnv = (mkNixvim leanEnvAttrs).result;
  workEnv = "";
}
