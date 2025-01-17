{ pkgs }:

let
  inherit (pkgs.stdenv) isDarwin isLinux isi686 isx86_64 isAarch32 isAarch64;
  vscode-utils = pkgs.vscode-utils;
  merge = pkgs.lib.attrsets.recursiveUpdate;
in
merge
  (merge
    (merge
      (merge
      {
        "banacorn"."agda-mode" = vscode-utils.extensionFromVscodeMarketplace {
          name = "agda-mode";
          publisher = "banacorn";
          version = "0.4.7";
          sha256 = "0kb35hs2830nihxwk91kq9fhibmr2gl6mihv0ll7lgx5bsgvgml0";
        };
        "leanprover"."lean4" = vscode-utils.extensionFromVscodeMarketplace {
          name = "lean4";
          publisher = "leanprover";
          version = "0.0.191";
          sha256 = "1zwx1dc1hvppzz2vnlzwia4lmkg1zvkdpq4v80vfg9lv756i5lls";
        };
        "maximedenes"."vscoq" = vscode-utils.extensionFromVscodeMarketplace {
          name = "vscoq";
          publisher = "maximedenes";
          version = "2.2.3";
          sha256 = "066l48b22qnxlwnq2328wmldn2dwrjn5d399rp605ahdihl9f7w7";
        };
      }
        (pkgs.lib.attrsets.optionalAttrs (isLinux && (isi686 || isx86_64)) { }))
      (pkgs.lib.attrsets.optionalAttrs (isLinux && (isAarch32 || isAarch64)) { }))
    (pkgs.lib.attrsets.optionalAttrs (isDarwin && (isi686 || isx86_64)) { }))
  (pkgs.lib.attrsets.optionalAttrs (isDarwin && (isAarch32 || isAarch64)) { })
