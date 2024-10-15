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
  cfg = config.${namespace}.programs.tldr;
in {
  options.${namespace}.programs.tldr = with types; {
    enable = mkBoolOpt false "Whether or not to enable Tldr (simplified man pages).";
  };

  config = mkIf cfg.enable {
  
    home.packages = with pkgs; [
      tldr
    ];

  };
}