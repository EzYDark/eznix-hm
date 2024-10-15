{
  options,
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.programs.editor.zed;
in {
  options.${namespace}.programs.editor.zed = with types; {
    enable = mkBoolOpt false "Whether or not to enable Zed editor.";
  };

  config = mkIf cfg.enable {
  
    home.packages = with pkgs; [
      zed-editor
    ];

  };
}