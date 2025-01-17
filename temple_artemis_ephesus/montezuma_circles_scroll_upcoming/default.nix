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
  # disabled while using emergency agda config
  # agdaEnvAttrs = {
  #   plugins = import ./resources/emergencyAgdaConfig/pluginsCore.nix { inherit pkgs; };
  #   filetype = {};
  #   extraPlugins = import ./resources/emergencyAgdaConfig/agda.nix { inherit pkgs; };
  #   extraConfigLua = "";
  #   packagesApartFromNixvim = with pkgs; [ agda luajitPackages.luautf8 ];
  # };
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
  agdaEnv = agdaLspPackage: import ./tempAgdaConfig.nix { inherit pkgs; inherit nixvimFlakeInput; inherit system; inherit agdaLspPackage; };
}
