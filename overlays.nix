{lib}: let
  libOverlay = _f: p: {
    lib = p.lib.extend (_: _: {
      inherit (lib) withPlugins writeIf withAttrSet;
    });
  };
in {
  overlays = [lib.buildPluginOverlay libOverlay];
}
