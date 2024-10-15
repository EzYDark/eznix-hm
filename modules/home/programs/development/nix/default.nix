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
  cfg = config.${namespace}.programs.development.nix;
in {
  options.${namespace}.programs.development.nix = with types; {
    enable = mkBoolOpt false "Whether or not to enable Nix language dev tools.";
  };

  config = mkIf cfg.enable {
  
    home.packages = with pkgs; [
      nil
      nixfmt-rfc-style
    ];

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

  };
}