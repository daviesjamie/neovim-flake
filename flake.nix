{
  description = "jagd's neovim configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    neovim = {
      url = github:neovim/neovim/stable?dir=contrib;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    "plugin:cmp-buffer" = {
      url = github:hrsh7th/cmp-buffer;
      flake = false;
    };

    "plugin:cmp-nvim-lsp" = {
      url = github:hrsh7th/cmp-nvim-lsp;
      flake = false;
    };

    "plugin:cmp-nvim-lua" = {
      url = github:hrsh7th/cmp-nvim-lua;
      flake = false;
    };

    "plugin:cmp-path" = {
      url = github:hrsh7th/cmp-path;
      flake = false;
    };

    "plugin:comment-nvim" = {
      url = github:numToStr/Comment.nvim;
      flake = false;
    };

    "plugin:lsp-zero" = {
      url = github:VonHeikemen/lsp-zero.nvim/dev-v3;
      flake = false;
    };

    "plugin:luasnip" = {
      url = github:L3MON4D3/LuaSnip;
      flake = false;
    };

    "plugin:nvim-cmp" = {
      url = github:hrsh7th/nvim-cmp;
      flake = false;
    };

    "plugin:nvim-lspconfig" = {
      url = github:neovim/nvim-lspconfig;
      flake = false;
    };

    "plugin:nvim-treesitter-context" = {
      url = github:nvim-treesitter/nvim-treesitter-context;
      flake = false;
    };

    "plugin:plenary-nvim" = {
      url = github:nvim-lua/plenary.nvim;
      flake = false;
    };

    "plugin:rose-pine" = {
      url = github:rose-pine/neovim;
      flake = false;
    };

    "plugin:telescope-nvim" = {
      url = github:nvim-telescope/telescope.nvim;
      flake = false;
    };

    "plugin:trouble-nvim" = {
      url = github:folke/trouble.nvim;
      flake = false;
    };

    "plugin:vim-fugitive" = {
      url = github:tpope/vim-fugitive;
      flake = false;
    };

    "plugin:vim-ledger" = {
      url = github:ledger/vim-ledger;
      flake = false;
    };

    "plugin:vim-sleuth" = {
      url = github:tpope/vim-sleuth;
      flake = false;
    };

    "plugin:vim-surround" = {
      url = github:tpope/vim-surround;
      flake = false;
    };

    "plugin:which-key-nvim" = {
      url = github:folke/which-key.nvim;
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
