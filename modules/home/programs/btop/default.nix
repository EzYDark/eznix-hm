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
  cfg = config.${namespace}.programs.btop;
in {
  options.${namespace}.programs.btop = with types; {
    enable = mkBoolOpt false "Whether or not to enable Btop.";
  };

  config = mkIf cfg.enable {
  
    programs.btop = {
      enable = true;
    };

  };
}