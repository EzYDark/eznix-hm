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
  cfg = config.${namespace}.programs.mako;
in {
  options.${namespace}.programs.mako = with types; {
    enable = mkBoolOpt false "Whether or not to enable Mako the notification daemon.";
  };

  config = mkIf cfg.enable {
  
    services.mako = {
      enable = true;
      defaultTimeout = 5000;
    };

  };
}