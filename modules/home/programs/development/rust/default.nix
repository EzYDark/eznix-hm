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
  cfg = config.${namespace}.programs.development.rust;
in {
  options.${namespace}.programs.development.rust = with types; {
    enable = mkBoolOpt false "Whether or not to enable Rust language dev tools.";
  };

  config = mkIf cfg.enable {
  
    home.packages = with pkgs; [
      rustup
      sccache
      bacon

      gcc13
    ];

    home.sessionVariables = {
      RUSTC_WRAPPER = "${lib.getExe pkgs.sccache}";
    };

  };
}