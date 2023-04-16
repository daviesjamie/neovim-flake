{
  description = "jagd's neovim configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;

    neovim = {
      url = github:neovim/neovim?dir=contrib;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, neovim, nixpkgs }: {
    packages.aarch64-darwin.default = neovim.packages.aarch64-darwin.neovim;
    apps.aarch64-darwin.default = {
      type = "app";
      program = "${neovim.packages.aarch64-darwin.neovim}/bin/nvim";
    };
  };
}
