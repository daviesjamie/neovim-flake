{
  inputs,
  pkgs,
  plugins,
  ...
}: {
  buildPluginOverlay = import ./buildPluginOverlay.nix {inherit inputs plugins;};
  neovimBuilder = import ./neovimBuilder.nix {inherit pkgs;};
}
