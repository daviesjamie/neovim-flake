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
      lib = import ./lib {inherit inputs pkgs plugins;};

      neovimBuilder = lib.neovimBuilder;

      plugins = [
        "rose-pine"
      ];

      pluginOverlay = lib.buildPluginOverlay;

      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          inputs.neovim-nightly-overlay.overlay
          pluginOverlay
        ];
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
