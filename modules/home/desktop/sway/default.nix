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
  cfg = config.${namespace}.desktop.sway;
in {
  options.${namespace}.desktop.sway = with types; {
    enable = mkBoolOpt false "Whether or not to enable Sway desktop";
  };

  config = mkIf cfg.enable {

    xdg.portal = {
      enable = true;
      configPackages = [pkgs.xdg-desktop-portal-wlr];
      extraPortals = [pkgs.xdg-desktop-portal-wlr];
    };

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      systemd.variables = ["--all"];
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };

      config = rec {
        bars = [];
        modifier = "Mod4";

        defaultWorkspace = "workspace number 1";

        floating.criteria = [
          {app_id = ".blueman-manager-wrapped";}
          {app_id = "blueberry.py";}
          {app_id = "com.github.wwmm.easyeffects";}
          {app_id = "nm-connection-editor";}
          {app_id = "pavucontrol";}
          {app_id = "solaar";}
          {title = "Open File";}
          {title = "Open Folder";}
          {window_role = "bubble";}
          {window_role = "dialog";}
          {window_role = "pop-up";}
          {window_type = "dialog";}
        ];

        focus = {
          followMouse = "always";
          newWindow = "focus";
        };

        gaps = {
          inner = 3;
          outer = 6;
        };

        input = {
          "type:pointer" = {
            accel_profile = "flat";
          };

          "type:touchpad" = {
            accel_profile = "adaptive";
            pointer_accel = "-0.25";
            scroll_factor = "0.25";
            click_method = "clickfinger";
            dwt = "enabled";
            natural_scroll = "enabled";
            scroll_method = "two_finger";
            tap = "enabled";
            tap_button_map = "lrm";
          };

          "type:keyboard" = {
            xkb_layout = "cz";
          };
        };

        output = {
          "eDP-1" = {
            mode = "2160x1440@60.001Hz";
            scale = "1.5";
            # allow_tearing = "yes";
            max_render_time = "off";
          };
          "HDMI-A-1" = {
            mode = "1920x1080@120.000Hz";
            scale = "1";
            # allow_tearing = "yes";
            max_render_time = "off";
          };
        };

        workspaceOutputAssign = [
          {
            workspace = "1";
            output = "eDP-1";
          }
          {
            workspace = "2";
            output = "HDMI-A-1";
          }
        ];



        keybindings = {
          "${modifier}+F" = "exec ${lib.getExe pkgs.firefox-devedition}";
          "${modifier}+E" = "exec ${lib.getExe pkgs.xfce.thunar}";
          "${modifier}+R" = "exec ${lib.getExe pkgs.rofi-wayland} -show drun -show-icons";
          "${modifier}+T" = "exec ${lib.getExe pkgs.kitty}";
          "${modifier}+C" = "kill";
          "${modifier}+Shift+D" = "floating toggle";
          "${modifier}+Shift+F" = "fullscreen toggle";
          "${modifier}+Shift+A" = "mode Move";
          "${modifier}+Shift+S" = "mode Resize";
          "XF86MonBrightnessUp" = "exec ${lib.getExe pkgs.brightnessctl} s 5%+";
          "XF86MonBrightnessDown" = "exec ${lib.getExe pkgs.brightnessctl} s 5%-";
          "XF86AudioMute" = "exec ${lib.getExe pkgs.pamixer} --toggle-mute";
          "XF86AudioRaiseVolume" = "exec ${lib.getExe pkgs.pamixer} -i 5";
          "XF86AudioLowerVolume" = "exec ${lib.getExe pkgs.pamixer} -d 5";
          "${modifier}+up" = "focus up";
          "${modifier}+down" = "focus down";
          "${modifier}+left" = "focus left";
          "${modifier}+right" = "focus right";
          "control+tab" = "workspace back_and_forth";
          "${modifier}+tab" = "workspace back_and_forth";

          "${modifier}+plus" = "workspace 1";
          "${modifier}+ecaron" = "workspace 2";
          "${modifier}+scaron" = "workspace 3";
          "${modifier}+ccaron" = "workspace 4";
          "${modifier}+rcaron" = "workspace 5";
          "${modifier}+zcaron" = "workspace 6";
          "${modifier}+yacute" = "workspace 7";
          "${modifier}+aacute" = "workspace 8";
          "${modifier}+iacute" = "workspace 9";
          "${modifier}+eacute" = "workspace 0";

          "${modifier}+shift+plus" = "move window to workspace 1; workspace 1";
          "${modifier}+shift+ecaron" = "move window to workspace 2; workspace 2";
          "${modifier}+shift+scaron" = "move window to workspace 3; workspace 3";
          "${modifier}+shift+ccaron" = "move window to workspace 4; workspace 4";
          "${modifier}+shift+rcaron" = "move window to workspace 5; workspace 5";
          "${modifier}+shift+zcaron" = "move window to workspace 6; workspace 6";
          "${modifier}+shift+yacute" = "move window to workspace 7; workspace 7";
          "${modifier}+shift+aacute" = "move window to workspace 8; workspace 8";
          "${modifier}+shift+iacute" = "move window to workspace 9; workspace 9";
          "${modifier}+shift+eacute" = "move window to workspace 0; workspace 0";

        };

        modes = {
          "Move" = {
            Escape = "mode default";
            "${modifier}+Shift+A" = "mode default";
            "${modifier}+Shift+S" = "mode Resize";
            Period = "move container to workspace prev; workspace prev";
            Comma = "move container to workspace next; workspace next";
          };

          "Resize" = {
            Escape = "mode default";
            "${modifier}+Shift+S" = "mode default";
            "${modifier}+Shift+A" = "mode Move";
            Right = "resize shrink width 24 px";
            Up = "resize grow height 24 px";
            Down = "resize shrink height 24 px";
            Left = "resize grow width 24 px";
          };
        };

        startup = [
          {command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";}
          {command = "${lib.getExe pkgs.autotiling}";}
          {command = "${pkgs.ydotool}/bin/ydotoold";}
        ];

        window = {
          titlebar = false;

          commands = [
            {
              command = "border pixel 4"; # Workaround for libadwaita + CSD apps not having borders when floating.
              criteria = {all = true;};
            }
            {
              command = "floating enable; sticky toggle; resize 35ppt 10ppt";
              criteria = {
                title = "^Picture-in-Picture$";
                app_id = "firefox";
              };
            }
            {
              command = "focus; sticky toggle";
              criteria = {app_id = "gcr-prompter";};
            }
            {
              command = "focus; sticky toggle";
              criteria = {app_id = "polkit-gnome-authentication-agent-1";};
            }
            {
              command = "floating enable; resize set 40ppt 20ppt; move position center";
              criteria = {title = "File Operation Progress";};
            }
            {
              command = "resize set 40ppt 60ppt; move position center";
              criteria = {title = "Open Folder";};
            }
            {
              command = "resize set 40ppt 60ppt; move position center";
              criteria = {title = "Open File";};
            }
            {
              command = "resize set 40ppt 60ppt; move position center";
              criteria = {app_id = "blueberry.py";};
            }
            {
              command = "resize set 60ppt 80ppt; move position center";
              criteria = {app_id = "solaar";};
            }
            {
              command = "resize set 40ppt 60ppt; move position center";
              criteria = {app_id = ".blueman-manager-wrapped";};
            }
            {
              command = "resize set 40ppt 60ppt; move position center";
              criteria = {app_id = "nm-connection-editor";};
            }
            {
              command = "resize set 40ppt 60ppt; move position center";
              criteria = {app_id = "pavucontrol";};
            }
          ];
        };

        workspaceAutoBackAndForth = true;
      };

      extraConfig =
        ''
          mode "Move" {
            bindgesture pinch:inward+down move down
            bindgesture pinch:inward+left move left
            bindgesture pinch:inward+right move right
            bindgesture pinch:inward+up move up
            bindgesture swipe:down move container to workspace prev; workspace prev
            bindgesture swipe:left move container to workspace next; workspace next
            bindgesture swipe:right move container to workspace prev; workspace prev
            bindgesture swipe:up move container to workspace next; workspace next
          }

          bindgesture swipe:left exec "${lib.getExe pkgs.ydotool} click 0xC4"
          bindgesture swipe:right exec "${lib.getExe pkgs.ydotool} click 0xC3"
          bindgesture swipe:up exec "${lib.getExe pkgs.playerctl} previous"
          bindgesture swipe:down exec "${lib.getExe pkgs.playerctl} next"

          default_border pixel 4
          default_floating_border pixel 4
        '';
    };
  };

}