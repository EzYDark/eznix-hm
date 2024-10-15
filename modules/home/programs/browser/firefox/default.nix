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
  cfg = config.${namespace}.programs.browser.firefox;
in {
  options.${namespace}.programs.browser.firefox = with types; {
    enable = mkBoolOpt false "Whether or not to enable Firefox browser.";
  };

  config = mkIf cfg.enable {
  
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-devedition;
    };

  };
}