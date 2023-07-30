{
  pkgs,
  lib,
  config,
  appName ? "nvim",
  viAlias ? false,
  vimAlias ? false,
  isolated ? true,
  extraPackages ? [],
}: let
  plugins = [
    pkgs.neovimPlugins.comment-nvim
    pkgs.neovimPlugins.nvim-treesitter-context
    pkgs.neovimPlugins.plenary-nvim
    pkgs.neovimPlugins.rose-pine
    pkgs.neovimPlugins.telescope-nvim
    pkgs.neovimPlugins.vim-fugitive
    pkgs.neovimPlugins.vim-ledger
    pkgs.neovimPlugins.vim-sleuth
    pkgs.neovimPlugins.vim-surround
    pkgs.vimPlugins.nvim-treesitter.withAllGrammars
  ];

  nvimConfig = pkgs.neovimUtils.makeNeovimConfig {
    inherit plugins viAlias vimAlias;
    withPython3 = false;
    withRuby = false;
  };

  stdpath = {
    inherit config;
    cache = "/tmp/nvim-cache";
    data = "/tmp/nvim-data";
    state = "/tmp/nvim-state";
  };

  hasExtraPackages = extraPackages != [];
in
  pkgs.wrapNeovimUnstable pkgs.neovim
  (
    nvimConfig
    // {
      wrapperArgs = lib.escapeShellArgs (nvimConfig.wrapperArgs
        ++ ["--set" "NVIM_APPNAME" appName]
        ++ lib.optionals hasExtraPackages ["--suffix" "PATH" ":" "${lib.makeBinPath extraPackages}"]
        ++ lib.optionals isolated [
          "--set"
          "XDG_CONFIG_HOME"
          "${stdpath.config}"
          "--set"
          "XDG_CACHE_HOME"
          "${stdpath.cache}"
          "--set"
          "XDG_DATA_HOME"
          "${stdpath.data}"
          "--set"
          "XDG_STATE_HOME"
          "${stdpath.state}"
        ]);
      wrapRc = false;
    }
  )
