{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  imports = [./languages/clojure.nix ./languages/dart.nix];
  options.cljnvim.languages.enable = mkEnableOption "Enables programming languages support";
}
