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
  cfg = config.${namespace}.programs.development.git;
in {
  options.${namespace}.programs.development.git = with types; {
    enable = mkBoolOpt false "Whether or not to enable Git.";
  };

  config = mkIf cfg.enable {
  
    programs = {
      git.enable = true;
    };

  };
}