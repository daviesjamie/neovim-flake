{
  description = "jagd's neovim configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;

    neovim-nightly-overlay = {
      url = github:nix-community/neovim-nightly-overlay;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rose-pine = {
      url = github:rose-pine/neovim;
      flake = false;
    };
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      plugins = [
        "rose-pine"
      ];

      pluginOverlay = final: prev: let
        buildPlug = name:
          prev.vimUtils.buildVimPluginFrom2Nix {
            pname = name;
            version = "master";
            src = builtins.getAttr name inputs;
          };
      in {
        neovimPlugins =
          builtins.listToAttrs
          (map (name: {
              inherit name;
              value = buildPlug name;
            })
            plugins);
      };

      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          inputs.neovim-nightly-overlay.overlay
          pluginOverlay
        ];
      };

      neovimBuilder = {
        customRC ? "",
        viAlias ? true,
        vimAlias ? true,
        start ? builtins.attrValues pkgs.neovimPlugins,
        opt ? [],
      }:
        pkgs.wrapNeovim pkgs.neovim-nightly {
          configure = {
            inherit customRC viAlias vimAlias;

            packages.jagd = {
              inherit start opt;
            };
          };
        };
    in rec {
      apps.default = {
        type = "app";
        program = "${packages.default}/bin/nvim";
      };

      formatter = pkgs.alejandra;

      packages = rec {
        default = neovimJagd;
        neovimJagd = neovimBuilder {
          customRC = ''
            colorscheme rose-pine
            echom "Hello from jagd"
          '';
        };
      };
    });
}
