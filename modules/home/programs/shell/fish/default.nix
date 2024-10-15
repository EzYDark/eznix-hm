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
  cfg = config.${namespace}.programs.shell.fish;
in {
  options.${namespace}.programs.shell.fish = with types; {
    enable = mkBoolOpt false "Whether or not to enable Fish shell.";
  };

  config = mkIf cfg.enable {
  
    programs.fish = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };
    };

  };
}