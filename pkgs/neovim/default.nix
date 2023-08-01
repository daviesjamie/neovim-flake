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
  lsps =
    (with pkgs; [
      lua-language-server
      nil
    ])
    ++ (with pkgs.nodePackages; [
      bash-language-server
      typescript-language-server
    ]);

  runtimePackages = lsps ++ extraPackages;

  plugins =
    (with pkgs.neovimPlugins; [
      comment-nvim
      nvim-lspconfig
      nvim-treesitter-context
      plenary-nvim
      rose-pine
      telescope-nvim
      vim-fugitive
      vim-ledger
      vim-sleuth
      vim-surround
      which-key-nvim
    ])
    ++ [pkgs.vimPlugins.nvim-treesitter.withAllGrammars];

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
in
  pkgs.wrapNeovimUnstable pkgs.neovim
  (
    nvimConfig
    // {
      wrapperArgs = lib.escapeShellArgs (nvimConfig.wrapperArgs
        ++ ["--set" "NVIM_APPNAME" appName]
        ++ ["--suffix" "PATH" ":" "${lib.makeBinPath runtimePackages}"]
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
