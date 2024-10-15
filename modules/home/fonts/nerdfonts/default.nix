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
  cfg = config.${namespace}.fonts.nerdfonts;
in {
  options.${namespace}.fonts.nerdfonts = with types; {
    enable = mkBoolOpt false "Whether or not to enable Nerdfonts.";
  };

  config = mkIf cfg.enable {
  
    home.packages = with pkgs; [
      nerdfonts
    ];

  };
}