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
  cfg = config.${namespace}.programs.kdeconnect;
in {
  options.${namespace}.programs.kdeconnect = with types; {
    enable = mkBoolOpt false "Whether or not to enable KDE Connect.";
  };

  config = mkIf cfg.enable {
  
    services.kdeconnect = {
      enable = true;
      indicator = true;
    };

  };
}