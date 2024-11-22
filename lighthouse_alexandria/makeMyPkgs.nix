{ lib, ...}@inputs:
let 
  helpers = import ./. {inherit lib;};
in
args @ {dirpath, helpers, ...} :
  let
  dirAttrs = builtins.readDir dirpath;
  isDirPredicate = name: value: value == "directory";
  onlyDirectoriesAttrs = lib.attrsets.filterAttrs isDirPredicate dirAttrs;
  onlyDirectories = builtins.attrNames onlyDirectoriesAttrs;
  toAppendableFilepathString = map (dirname : "/" + dirname) onlyDirectories;
  toFullFilepath = map (suffix: dirpath + suffix) toAppendableFilepathString;
  makeNamePkgPair = filepath: {
    name = helpers.getSuffixlessBasename filepath;
    value = import filepath args;
  };
  in
  builtins.listToAttrs (map makeNamePkgPair toFullFilepath)
