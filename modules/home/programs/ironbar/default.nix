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
  cfg = config.${namespace}.programs.ironbar;
in {
  options.${namespace}.programs.ironbar = with types; {
    enable = mkBoolOpt false "Whether or not to enable Ironbar (Waybar replacement).";
  };

  config = mkIf cfg.enable {
  
    programs.ironbar = {
      enable = true;
      config = rec {
        position = "top";
        layer = "bottom";
        height = 1;
        margin.top = 10;
        margin.left = margin.top;
        margin.right = margin.top;
        start = [
            {
                type = "workspaces";
                # name_map = {
                #     "1" = "";
                #     "2" = "";
                #     "3" = "";
                # };
                icon_size = 32;
                favorites = ["1" "2" "3" "4" "5"];
                all_monitors = true;
            }
            {
                type = "sway_mode";
                truncate = "start";
            }
            {
                type = "tray";
                icon_size = 32;
            }
        ];
        center = [];
        end = [
            {
                type = "network_manager";
                icon_size = 32;
            }
            {
                type = "upower";
                icon_size = 32;
                format = "{percentage}% {state} {time_remaining}";
            }
            {
                type = "clipboard";
                max_items = 5;
            }
            {
                type = "volume";
                format = "{icon} {percentage}%";
                max_volume = 100;
                icons = {
                    volume_high = "󰕾";
                    volume_medium = "󰖀";
                    volume_low = "󰕿";
                    muted = "󰝟";
                };
            }
            {
                type = "clock";
                format = "%d/%m/%Y %H:%M";
            }
        ];
      };

      style = builtins.readFile ./style.css;
    };

  };
}