{
  config,
  lib,
  osConfig,
  namespace,
  pkgs,
  ...
}:
with lib;
with lib.${namespace}; {
  snowfallorg.user.enable = true;

  eznix = {
    fonts = {
      nerdfonts = enabled;
      nunito = enabled;
    };
    desktop = {
      sway = enabled;
    };
    programs = {
      shell = {
        fish = {
          enable = true;
          default = enabled;
        };
      };
      editor = {
        vscode = enabled;
        zed = enabled;
      };
      development = {
        git = enabled;
        nix = enabled;
        rust = enabled;
      };
      ssh = enabled;
      git = enabled;
      home-manager = enabled;
      discord = enabled;
      spotify = enabled;
      browser.firefox = enabled;
      kitty = enabled;
      mako = enabled;
      tldr = enabled;
      waybar = enabled;
      poweralertd = enabled;
      btop = enabled;
    };
  };

  catppuccin = rec {
    enable = true;
    accent = "green";
    flavor = "mocha";
    pointerCursor = {
      enable = true;
      accent = accent;
      flavor = flavor;
    };
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    EDITOR = "${lib.getExe pkgs.vscode-fhs}";
    BROWSER = "${lib.getExe pkgs.firefox-devedition}";
    # QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    POLKIT_AUTH_AGENT = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  };

  home.packages = with pkgs; [
    xfce.thunar
    rofi-wayland
    autotiling
    polkit_gnome
    xdg-desktop-portal-wlr
    greetd.tuigreet
    bluez
    pavucontrol
  ];


  home.stateVersion = lib.mkDefault (osConfig.system.stateVersion or "24.05");
}
