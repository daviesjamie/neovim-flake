{inputs, ...}: final: prev: let
  plugins =
    builtins.filter
    (s: (builtins.match "plugin:.*" s) != null)
    (builtins.attrNames inputs);

  pluginName = inputName:
    builtins.substring
    (builtins.stringLength "plugin:")
    (builtins.stringLength inputName)
    inputName;

  buildPlugin = name:
    prev.vimUtils.buildVimPluginFrom2Nix {
      pname = pluginName name;
      version = (builtins.getAttr name inputs).shortRev;
      src = builtins.getAttr name inputs;
    };
in {
  neovimPlugins =
    builtins.listToAttrs
    (map (plugin: {
        name = pluginName plugin;
        value = buildPlugin plugin;
      })
      plugins);
}
