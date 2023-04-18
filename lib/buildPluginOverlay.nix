{inputs, ...}: final: prev: let
  plugins =
    builtins.filter
    (s: (builtins.match "plugin:.*" s) != null)
    (builtins.attrNames inputs);

  plugName = inputName:
    builtins.substring
    (builtins.stringLength "plugin:")
    (builtins.stringLength inputName)
    inputName;

  buildPlug = name:
    prev.vimUtils.buildVimPluginFrom2Nix {
      pname = plugName name;
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
}
