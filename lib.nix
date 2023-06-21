{
  pkgs,
  inputs,
}: let
  inherit (pkgs.lib) evalModules;
in {
  withPlugins = cond: plugins:
    if cond
    then plugins
    else [];
  writeIf = cond: msg:
    if cond
    then msg
    else "";

  mkNeovim = {config}: let
    inherit (builtins) filter;
    inherit (pkgs.lib.trivial) pipe;
    inherit (pkgs.lib.strings) stringToCharacters concatStrings;
    cljnvim = opts.config.cljnvim;
    isNotNewline = str: (str != "\n") || (str != "\t");
    minifyLua = contents:
      pipe contents [
        stringToCharacters
        (filter isNotNewline)
        concatStrings
      ];
    opts = evalModules {
      modules = [{imports = [./modules];} config];
      specialArgs = {inherit pkgs;};
    };
  in
    pkgs.wrapNeovim pkgs.neovim-unwrapped {
      withNodeJs = true;
      withPython3 = true;
      configure = {
        customRC = minifyLua cljnvim.configRC;
        packages.myVimPackage = {
          start = cljnvim.startPlugins;
          opt = cljnvim.optPlugins;
        };
      };
    };

  buildPluginOverlay = _super: self: let
    inherit (pkgs.lib.lists) last filter;
    inherit (pkgs.lib.strings) splitString;
    inherit (pkgs.lib.attrsets) attrByPath getAttr;
    inherit (pkgs.lib.trivial) pipe;
    inherit (builtins) attrNames listToAttrs;
    inherit (self.vimUtils) buildVimPluginFrom2Nix;
    isPlugin = n: n != "nixpkgs" && n != "flake-utils";
    plugins = filter isPlugin (attrNames inputs);
    getPluginVersionOrHEAD = name: plugins:
      pipe plugins [
        (attrByPath [name "url"] "HEAD")
        (splitString "/")
        last
      ];
    buildPlug = name:
      buildVimPluginFrom2Nix {
        pname = name;
        version = getPluginVersionOrHEAD name inputs;
        src = getAttr name inputs;
      };
    toVimPlug = name: {
      inherit name;
      value = buildPlug name;
    };
  in {
    neovimPlugins = listToAttrs (map toVimPlug plugins);
  };
}
