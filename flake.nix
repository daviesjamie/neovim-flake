{
  description = "jagd's neovim configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    neovim = {
      url = github:neovim/neovim/stable?dir=contrib;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    "plugin:comment-nvim" = {
      url = github:numToStr/Comment.nvim;
      flake = false;
    };

    "plugin:nvim-treesitter-context" = {
      url = github:nvim-treesitter/nvim-treesitter-context;
      flake = false;
    };

    "plugin:rose-pine" = {
      url = github:rose-pine/neovim;
      flake = false;
    };

    "plugin:vim-ledger" = {
      url = github:ledger/vim-ledger;
      flake = false;
    };
  };

  outputs = {self, ...} @ inputs: let
    forEachSystem = f:
      inputs.nixpkgs.lib.genAttrs staticLib.allSystems (system:
        f {
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              neovimOverlay
              pluginOverlay
            ];
          };
        });

    neovimOverlay = final: prev: {
      neovim = inputs.neovim.packages.${prev.system}.default;
    };

    pluginOverlay = self.lib.buildPluginOverlay;

    staticLib = import ./lib {inherit inputs;};
  in {
    apps = forEachSystem ({pkgs}: {
      default = {
        type = "app";
        program = "${self.packages.${pkgs.system}.default}/bin/nvim";
      };
    });

    devShell = forEachSystem ({pkgs}:
      pkgs.mkShell {
        buildInputs = [pkgs.stylua self.packages.${pkgs.system}.default];
      });

    formatter = forEachSystem ({pkgs}: pkgs.alejandra);

    homeManagerModules.default = import ./modules/home-manager.nix self;

    lib =
      forEachSystem ({pkgs}: {
        makeNeovimBundle = args: (pkgs.callPackage ./pkgs/bundle.nix args);
      })
      // staticLib;

    overlays = {
      neovim = neovimOverlay;
    };

    packages = forEachSystem ({pkgs}: {
      default = (self.lib.${pkgs.system}.makeNeovimBundle {}).neovim;
    });
  };
}
