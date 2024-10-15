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
          inner = 5;
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



        keybindings =
          {
            "${modifier}+F" = "exec ${lib.getExe pkgs.firefox-devedition}";
            "${modifier}+C" = "kill";
            "${modifier}+Comma" = "workspace prev";
            "${modifier}+V" = "exec ${lib.getExe pkgs.vscode-fhs}";
            "${modifier}+E" = "exec ${lib.getExe pkgs.xfce.thunar}";
            "${modifier}+F11" = "exec pkill -SIGUSR1 waybar"; # Show/hide waybar
            "${modifier}+Period" = "workspace next";
            "${modifier}+R" = "exec ${lib.getExe pkgs.rofi-wayland} -show combi";
            "${modifier}+Shift+Backslash" = "layout toggle split";
            "${modifier}+Shift+Comma" = "move container to workspace prev; workspace prev";
            "${modifier}+Shift+G" = "layout toggle splitv tabbed";
            "${modifier}+Shift+Period" = "move container to workspace next; workspace next";
            "${modifier}+Shift+R" = "exec ${lib.getExe pkgs.rofi-wayland} -show run";
            "${modifier}+Shift+V" = "floating toggle";
            "${modifier}+Shift+W" = "fullscreen toggle";
            "${modifier}+T" = "exec ${lib.getExe pkgs.kitty}";
            "${modifier}+Tab" = "exec ${lib.getExe pkgs.rofi-wayland} -show window";
            "Ctrl+Mod1+M" = "mode move";
            "Ctrl+Mod1+R" = "mode resize";
          };

        modes = {
          move =
            {
              Comma = "move container to workspace prev; workspace prev";
              Escape = "mode default";
              Period = "move container to workspace next; workspace next";
              S = "move scratchpad";
            };

          resize = {
            Escape = "mode default";
            Left = "resize shrink width 10 px";
            Down = "resize grow height 10 px";
            Up = "resize shrink height 10 px";
            Right = "resize grow width 10 px";
          };
        };

        startup = [
          {command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";}
          {command = lib.getExe pkgs.autotiling;}
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
          mode "move" {
            bindgesture pinch:inward+down move down
            bindgesture pinch:inward+left move left
            bindgesture pinch:inward+right move right
            bindgesture pinch:inward+up move up
            bindgesture swipe:down move container to workspace prev; workspace prev
            bindgesture swipe:left move container to workspace next; workspace next
            bindgesture swipe:right move container to workspace prev; workspace prev
            bindgesture swipe:up move container to workspace next; workspace next
          }

          bindgesture swipe:down workspace prev
          bindgesture swipe:left workspace next
          bindgesture swipe:right workspace prev
          bindgesture swipe:up workspace next

          default_border pixel 4
          default_floating_border pixel 4
        '';
    };
  };

}