{ pkgs }:
(with pkgs.vimPlugins; [
  nvim-surround
]) ++ [(pkgs.vimUtils.buildVimPlugin {
  name = "coq-lsp.nvim";
  src = "";
})]
