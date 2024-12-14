{ pkgs, nixvimFlakeInput, system, ...}:
let
  coreModule = import ./core/module.nix { inherit pkgs; };
  coreExtraPlugins = import ./core/extraPlugins.nix { inherit pkgs; };
  corePlugins = import ./plugins/pluginsCore.nix { inherit pkgs; };
  keymaps = import ./core/keymaps.nix;
  extraConfigLuaCore = pkgs.lib.concatStrings [
  (builtins.readFile ./extraConfigLua/rememberFolds.lua)
  (builtins.readFile ./extraConfigLua/tabKeyFunc.lua)
  (builtins.readFile ./extraConfigLua/toggleAbsRelNums.lua)
  (builtins.readFile ./extraConfigLua/setupNvimSurround.lua)
]; 
in
{ plugins, filetype, extraPlugins, extraConfigLua, packagesApartFromNixvim }:
let 
  argToNixvimMaker = 
      { 
        inherit pkgs;
        module = coreModule // { 
          keymaps = import ./core/keymaps.nix;
          extraPlugins = coreExtraPlugins ++ extraPlugins;
          plugins = plugins // (corePlugins // { lsp = corePlugins.lsp // { keymaps = import ./core/keymapsInPluginsLsp.nix; }; });
          inherit filetype;
          extraConfigLua = extraConfigLua + extraConfigLuaCore;
          }; 
        };
in
  {
argDebug = argToNixvimMaker;
result = (pkgs.symlinkJoin { 
  name = "nixvimPack"; 
  paths = packagesApartFromNixvim ++ [ pkgs.alejandra (nixvimFlakeInput.legacyPackages.${system}.makeNixvimWithModule argToNixvimMaker) ];
});
}
