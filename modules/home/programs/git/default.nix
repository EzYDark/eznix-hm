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
  cfg = config.${namespace}.programs.git;
in {
  options.${namespace}.programs.git = with types; {
    enable = mkBoolOpt false "Whether or not to enable Git.";
  };

  config = mkIf cfg.enable {
  
    programs.git = {
      enable = true;
      userName = "EzYDark";
      userEmail = "ezydark@protonmail.com";
      extraConfig = {
        user = {
          signingKey = "~/.ssh/ezKey.pub";
        };
        commit = { gpgSign = true; };
        gpg = { format = "ssh"; };
      };
    };

  };
}