{
  description = "jagd's neovim configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;

    neovim-nightly-overlay = {
      url = github:nix-community/neovim-nightly-overlay;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [inputs.neovim-nightly-overlay.overlay];
      };
    in {
      apps.default = {
        type = "app";
        program = "${pkgs.neovim-nightly}/bin/nvim";
      };

      formatter = pkgs.alejandra;

      packages.default = pkgs.neovim-nightly;
    });
}
