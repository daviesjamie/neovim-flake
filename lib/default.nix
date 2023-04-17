{
  inputs,
  plugins,
  ...
}: {
  buildPluginOverlay = import ./buildPluginOverlay.nix {inherit inputs plugins;};
}
