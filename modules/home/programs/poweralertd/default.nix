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
  cfg = config.${namespace}.programs.poweralertd;
in {
  options.${namespace}.programs.poweralertd = with types; {
    enable = mkBoolOpt false "Whether or not to enable Poweralertd to alert when the battery is low.";
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      poweralertd
    ];
  
    services.poweralertd = {
      enable = true;
    };

  };
}