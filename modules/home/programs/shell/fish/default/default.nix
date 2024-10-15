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
  cfg = config.${namespace}.programs.shell.fish.default;
in {
  options.${namespace}.programs.shell.fish.default = with types; {
    enable = mkBoolOpt false "Whether or not to set Fish as default shell.";
  };

  config = mkIf cfg.enable {
  
    home.sessionVariables = {
      SHELL = "${lib.getExe pkgs.fish}";
    };

    systemd.user.sessionVariables = {
      SHELL = "${lib.getExe pkgs.fish}";
    };

    # systems/x86_64-linux/eznix/users_groups.nix/users.users.*.shell

  };
}