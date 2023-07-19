{
  description = "jagd's neovim configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    neovim = {
      url = github:neovim/neovim/stable?dir=contrib;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    neovim,
  }: let
    allSystems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];

    forEachSystem = f:
      nixpkgs.lib.genAttrs allSystems (system:
        f {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [self.overlays.neovim];
          };
        });
  in {
    apps = forEachSystem ({pkgs}: {
      default = {
        type = "app";
        program = "${self.packages.${pkgs.system}.default}/bin/nvim";
      };
    });

    formatter = forEachSystem ({pkgs}: pkgs.alejandra);

    lib = forEachSystem ({pkgs}: {
      makeNeovimBundle = args: (pkgs.callPackage ./pkgs/bundle.nix args);
    });

    overlays = {
      neovim = final: prev: {
        neovim = neovim.packages.${prev.system}.default;
      };
    };

    packages = forEachSystem ({pkgs}: {
      default = (self.lib.${pkgs.system}.makeNeovimBundle {}).neovim;
    });
  };
}
