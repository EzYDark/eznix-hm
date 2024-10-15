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
  cfg = config.${namespace}.programs.editor.vscode;
in {
  options.${namespace}.programs.editor.vscode = with types; {
    enable = mkBoolOpt false "Whether or not to enable VSCode editor.";
  };

  config = mkIf cfg.enable {
  
    programs.vscode = {
      enable = true;
      package = pkgs.vscode-fhs;
    };

  };
}