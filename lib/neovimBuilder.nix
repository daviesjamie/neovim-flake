{pkgs, ...}: {
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
}
