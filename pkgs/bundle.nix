{
  pkgs,
  lib,
  appName ? "nvim",
  viAlias ? false,
  vimAlias ? false,
  isolated ? true,
  extraPackages ? [],
}: rec {
  config = pkgs.callPackage ./config {inherit pkgs appName;};
  neovim = pkgs.callPackage ./neovim {
    inherit pkgs lib config appName viAlias vimAlias isolated;
    extraPackages = extraPackages ++ [pkgs.lua-language-server pkgs.nil] ++ [pkgs.nodePackages.typescript-language-server pkgs.nodePackages.bash-language-server];
  };
}
