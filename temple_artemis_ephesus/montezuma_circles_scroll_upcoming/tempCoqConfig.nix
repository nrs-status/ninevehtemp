{ pkgs, nixvimFlakeInput, system, ...}:
  let 
  coreModule = import ./resources/core/module.nix { inherit pkgs; };
  coreExtraPlugins = import ./resources/core/extraPlugins.nix { inherit pkgs; };
  corePlugins = import ./resources/emergencyCoqConfig/pluginsCore.nix { inherit pkgs; };
  keymaps = import ./resources/core/keymaps.nix;
  extraConfigLuaCore = pkgs.lib.concatStrings [
    (builtins.readFile ./resources/extraConfigLua/rememberFolds.lua)
    (builtins.readFile ./resources/extraConfigLua/tabKeyFunc.lua)
    (builtins.readFile ./resources/extraConfigLua/tabKeyFunc.lua)
    (builtins.readFile ./resources/extraConfigLua/setupNvimSurround.lua)
  ];
in
  nixvimFlakeInput.legacyPackages.${system}.makeNixvimWithModule {
    inherit pkgs;
    module = coreModule // {
      keymaps = import ./resources/core/keymaps.nix;
      extraPlugins = coreExtraPlugins;
      plugins = (corePlugins // { lsp = corePlugins.lsp // {keymaps = import ./resources/core/keymapsInPluginsLsp.nix; }; });
      extraConfigLua = extraConfigLuaCore;
    };
  }
