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
  cfg = config.${namespace}.programs.ssh;
in {
  options.${namespace}.programs.ssh = with types; {
    enable = mkBoolOpt false "Whether or not to enable SSH client.";
  };

  config = mkIf cfg.enable {
  
    programs.ssh = {
      enable = true;
      compression = true;
      matchBlocks = {
        "github.com" = {
          user = "git";
          hostname = "github.com";
          identityFile = "~/.ssh/ezKey";
          extraOptions = {
            AddKeysToAgent = "yes";
          };
        };
      };
    };

    services.ssh-agent.enable = true;

  };
}