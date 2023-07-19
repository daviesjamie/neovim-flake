{pkgs}: {
  nvimConfig = pkgs.stdenv.mkDerivation {
    name = "nvim-config";
    src = ./.;
    installPhase = ''
      mkdir -p $out/nvim
      cp -r ./nvim/* $out/nvim/
    '';
  };
}
