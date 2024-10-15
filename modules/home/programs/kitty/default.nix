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
  cfg = config.${namespace}.programs.kitty;
in {
  options.${namespace}.programs.kitty = with types; {
    enable = mkBoolOpt false "Whether or not to enable Kitty terminal.";
  };

  config = mkIf cfg.enable {
  
    programs.kitty = {
      enable = true;
      font = {
        name = "Nunito";
        package = pkgs.texlivePackages.nunito;
      };
      keybindings = {
        "ctrl+c" = "copy_or_interrupt";
        "ctrl+v" = "paste_from_clipboard";
      };
      shellIntegration = {
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
      settings = {
        enable_audio_bell = true;
        notify_on_cmd_finish = "unfocused";
        confirm_os_window_close = 0;
      };
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };
    };

  };
}