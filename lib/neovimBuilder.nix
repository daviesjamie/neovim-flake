{
  inputs,
  pkgs,
}: {nvimConfig}: let
  neovimPackage = pkgs.neovim-nightly;

  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    withPython3 = false;
    withNodeJs = false;
    withRuby = false;
    extraPython3Packages = _: [];
    extraLuaPackages = _: [];

    plugins = builtins.attrValues pkgs.neovimPlugins;
    customRC = "";
  };

  wrappedNeovim = pkgs.wrapNeovimUnstable neovimPackage (neovimConfig
    // {
      wrapRc = false;
    });
in
  pkgs.writeShellApplication {
    name = "nvim";
    text = ''
      XDG_CONFIG_HOME="${nvimConfig.nvimConfig.outPath}" "${wrappedNeovim}/bin/nvim" "$@"
    '';
  }
