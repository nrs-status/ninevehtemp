{
  pkgs
}: 
[(pkgs.vimUtils.buildVimPlugin {
        name = "nvim-agda";
        src = pkgs.fetchFromGitHub {
            owner = "ashinkarov";
            repo = "nvim-agda";
            rev = "9024909ac5cbac0a0b6f1f3f7f2b65c907c8fc12";
            hash = "sha256-C2JWoCF2eeZFZ3J+1//FJ7FPqRE9w4CcwyEVI8vwZPw=";
        };
})]
