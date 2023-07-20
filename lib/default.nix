{inputs, ...}: {
  buildPluginOverlay = import ./buildPluginOverlay.nix {inherit inputs;};
}
