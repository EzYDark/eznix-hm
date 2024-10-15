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
  cfg = config.${namespace}.fonts.nunito;
in {
  options.${namespace}.fonts.nunito = with types; {
    enable = mkBoolOpt false "Whether or not to enable Nunito font.";
  };

  config = mkIf cfg.enable {
  
    home.packages = with pkgs; [
      texlivePackages.nunito
    ];

  };
}