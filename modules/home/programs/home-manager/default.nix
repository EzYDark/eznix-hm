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
  cfg = config.${namespace}.programs.home-manager;
in {
  options.${namespace}.programs.home-manager = with types; {
    enable = mkBoolOpt false "Whether or not to enable Home-Manager program.";
  };

  config = mkIf cfg.enable {
  
    # programs.home-manager = {
    #   enable = true;
    # };

    home.packages = with pkgs; [
      home-manager
    ];

  };
}