{inputs, ...}: {
  allSystems = [
    "aarch64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
    "x86_64-linux"
  ];

  buildPluginOverlay = import ./buildPluginOverlay.nix {inherit inputs;};
}
