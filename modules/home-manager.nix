self: {
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  inherit (self.lib.${pkgs.system}) makeNeovimBundle;
  cfg = config.programs.nvim;
in {
  options = {
    programs.nvim = {
      enable = mkEnableOption "Neovim";

      appName = mkOption {
        type = types.str;
        default = "nvim";
        description = ''
          The name to use for this neovim application (NVIM_APPNAME)
        '';
      };

      viAlias = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Symlink <command>vi</command> to <command>nvim</command> binary.
        '';
      };

      vimAlias = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Symlink <command>vim</command> to <command>nvim</command> binary.
        '';
      };

      isolated = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Executes neovim with its config isolated into a nix store. It
          replaces XDG_{CONFIG,CACHE,DATA,STATE}_HOME variables for
          neovim.
        '';
      };

      extraPackages = mkOption {
        type = types.listOf types.package;
        default = [];
        description = ''
          Extra packages to be used in neovim. Useful for common LSP servers
          and formatters.
        '';
      };
    };
  };

  config = let
    bundle = makeNeovimBundle {
      inherit (cfg) appName extraPackages isolated viAlias vimAlias;
    };
  in
    mkIf cfg.enable {
      home.packages = [bundle.neovim];
      xdg.configFile.${cfg.appName} = {
        enable = !cfg.isolated;
        source = "${bundle.config}/nvim";
        recursive = true;
        onChange = ''
          rm -rf ${config.xdg.cacheHome}/${cfg.appName}
        '';
      };
    };
}
