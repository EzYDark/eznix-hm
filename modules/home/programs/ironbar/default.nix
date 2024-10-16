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
        height = 30;
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

      style = "
        @define-color color_bg #2d2d2d;
        @define-color color_bg_dark #1c1c1c;
        @define-color color_border #424242;
        @define-color color_border_active #6699cc;
        @define-color color_text #ffffff;
        @define-color color_urgent #8f0a0a;

        /* -- base styles -- */

        * {
            font-family: Noto Sans Nerd Font, sans-serif;
            font-size: 16px;
            border: none;
            border-radius: 0;
        }

        box, menubar, button {
            background-color: @color_bg;
            background-image: none;
            box-shadow: none;
        }

        button, label {
            color: @color_text;
        }

        button:hover {
            background-color: @color_bg_dark;
        }

        scale trough {
            min-width: 1px;
            min-height: 2px;
        }

        #bar {
            border-top: 1px solid @color_border;
        }

        .popup {
            border: 1px solid @color_border;
            padding: 1em;
        }


        /* -- clipboard -- */

        .clipboard {
            margin-left: 5px;
            font-size: 1.1em;
        }

        .popup-clipboard .item {
            padding-bottom: 0.3em;
            border-bottom: 1px solid @color_border;
        }


        /* -- clock -- */

        .clock {
            font-weight: bold;
            margin-left: 5px;
        }

        .popup-clock .calendar-clock {
            color: @color_text;
            font-size: 2.5em;
            padding-bottom: 0.1em;
        }

        .popup-clock .calendar {
            background-color: @color_bg;
            color: @color_text;
        }

        .popup-clock .calendar .header {
            padding-top: 1em;
            border-top: 1px solid @color_border;
            font-size: 1.5em;
        }

        .popup-clock .calendar:selected {
            background-color: @color_border_active;
        }


        /* -- launcher -- */

        .launcher .item {
            margin-right: 4px;
        }

        .launcher .ifix examtem:not(.focused):hover {
            background-color: @color_bg_dark;
        }

        .launcher .open {
            border-bottom: 1px solid @color_text;
        }

        .launcher .focused {
            border-bottom: 1px solid @color_border_active;
        }

        .launcher .urgent {
            border-bottom-color: @color_urgent;
        }

        .popup-launcher {
            padding: 0;
        }

        .popup-launcher .popup-item:not(:first-child) {
            border-top: 1px solid @color_border;
        }


        /* -- music -- */

        .music:hover * {
            background-color: @color_bg_dark;
        }

        .popup-music .album-art {
            margin-right: 1em;
        }

        .popup-music .icon-box {
            margin-right: 0.4em;
        }

        .popup-music .title .icon, .popup-music .title .label {
            font-size: 1.7em;
        }

        .popup-music .controls *:disabled {
            color: @color_border;
        }

        .popup-music .volume .slider slider {
            border-radius: 100%;
        }

        .popup-music .volume .icon {
            margin-left: 4px;
        }

        .popup-music .progress .slider slider {
            border-radius: 100%;
        }

        /* notifications */

        .notifications .count {
            font-size: 0.6rem;
            background-color: @color_text;
            color: @color_bg;
            border-radius: 100%;
            margin-right: 3px;
            margin-top: 3px;
            padding-left: 4px;
            padding-right: 4px;
            opacity: 0.7;
        }

        /* -- script -- */

        .script {
            padding-left: 10px;
        }


        /* -- sys_info -- */

        .sysinfo {
            margin-left: 10px;
        }

        .sysinfo .item {
            margin-left: 5px;
        }


        /* -- tray -- */

        .tray {
            margin-left: 10px;
        }

        /* -- volume -- */

        .popup-volume .device-box {
            border-right: 1px solid @color_border;
        }

        /* -- workspaces -- */

        .workspaces .item.focused {
            box-shadow: inset 0 -3px;
            background-color: @color_bg_dark;
        }

        .workspaces .item:hover {
            box-shadow: inset 0 -3px;
        }


        /* -- custom: power menu -- */

        .popup-power-menu #header {
            font-size: 1.4em;
            padding-bottom: 0.4em;
            margin-bottom: 0.6em;
            border-bottom: 1px solid @color_border;
        }

        .popup-power-menu .power-btn {
            border: 1px solid @color_border;
            padding: 0.6em 1em;
        }

        .popup-power-menu #buttons > *:nth-child(1) .power-btn {
            margin-right: 1em;
        }

      ";
    };

  };
}