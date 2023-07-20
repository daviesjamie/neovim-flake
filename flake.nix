{
  description = "jagd's neovim configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
    neovim = {
      url = github:neovim/neovim/stable?dir=contrib;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    "plugin:rose-pine" = {
      url = github:rose-pine/neovim;
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    neovim,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      lib =
        {
          makeNeovimBundle = args: (pkgs.callPackage ./pkgs/bundle.nix args);
        }
        // import ./lib {inherit inputs;};

      neovimOverlay = final: prev: {
        neovim = neovim.packages.${prev.system}.default;
      };

      pluginOverlay = lib.buildPluginOverlay;

      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          neovimOverlay
          pluginOverlay
        ];
      };
    in rec {
      apps.default = {
        type = "app";
        program = "${packages.default}/bin/nvim";
      };

      formatter = pkgs.alejandra;

      lib = {
        makeNeovimBundle = args: (pkgs.callPackage ./pkgs/bundle.nix args);
      };

      overlays = {
        neovim = neovimOverlay;
      };

      packages.default = (lib.makeNeovimBundle {}).neovim;
    });
}
