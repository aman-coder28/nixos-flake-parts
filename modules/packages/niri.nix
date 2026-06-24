{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {

      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;

        settings = {
          input.keyboard.xkb.layout = "us";
          input.touchpad = {
            tap = _: { };
          };

          spawn-at-startup = [
            "${pkgs.mate-polkit}/libexec/polkit-mate-authentication-agent-1"

            (lib.getExe self'.packages.myNoctalia)
            (lib.getExe pkgs.hypridle)
            (lib.getExe pkgs.xwayland-satellite)
            [
              "wl-paste"
              "--type"
              "text"
              "--watch"
              "cliphist"
              "store"
            ]
            [
              "wl-paste"
              "--type"
              "image"
              "--watch"
              "cliphist"
              "store"
            ]
          ];

          window-rule = [
            {
              open-maximized = true;
              geometry-corner-radius = 11;
              clip-to-geometry = true;
            }
          ];

          hotkey-overlay = {
            skip-at-startup = _: { };
          };

          cursor = {
            xcursor-theme = "macOS";
            xcursor-size = 28;
          };

          layout = {
            gaps = 2;
            center-focused-column = "never";
            background-color = "transparent";

            preset-column-widths = [
              {
                proportion = 0.5;
              }
              { proportion = 0.999; }
            ];

            default-column-width = {
              proportion = 0.5;
            };

            focus-ring.off = _: { };
            border.off = _: { };
            shadow.off = _: { };
          };

          binds = {
            "Mod+Q".spawn = lib.getExe pkgs.ghostty;
            "Mod+Z".spawn = lib.getExe pkgs.zed-editor;
            "Mod+Space".spawn-sh = "noctalia msg panel-toggle launcher";
            "Mod+E".spawn = lib.getExe pkgs.nautilus;
            "Mod+B".spawn = "helium";
            "Mod+H".spawn-sh = "noctalia msg panel-toggle clipboard";
            "Mod+C".spawn = "cursor";
            "Mod+M".spawn = lib.getExe pkgs.gnome-system-monitor;
            "Mod+T".spawn = lib.getExe pkgs.gnome-text-editor;
            "Mod+L".spawn = lib.getExe pkgs.libreoffice-fresh;
            "Mod+W".spawn-sh = "noctalia msg panel-toggle wallpaper";
            "Mod+S".spawn-sh = "noctalia msg panel-toggle control-center";
            "Super+Alt+L".spawn = lib.getExe pkgs.hyprlock;

            "Mod+A".focus-column-left = _: { };
            "Mod+D".focus-column-right = _: { };
            "Mod+U".quit = _: { };
            "Mod+X".close-window = _: { };
            "Mod+R".switch-preset-column-width = _: { };
            "Mod+F".maximize-column = _: { };
            "Mod+V".toggle-window-floating = _: { };
            "Mod+O".toggle-overview = _: { };
            "Print".screenshot = _: { };
            "Ctrl+Print".screenshot-screen = _: { };
            "Alt+Print".screenshot-window = _: { };

            "Mod+Left".focus-column-left = _: { };
            "Mod+Down".focus-window-down = _: { };
            "Mod+Up".focus-window-up = _: { };
            "Mod+Right".focus-column-right = _: { };

            "Mod+Ctrl+Left".move-column-left = _: { };
            "Mod+Ctrl+Down".move-window-down = _: { };
            "Mod+Ctrl+Up".move-window-up = _: { };
            "Mod+Ctrl+Right".move-column-right = _: { };

            "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
            "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
            "XF86AudioMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            "XF86AudioMicMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

            "XF86MonBrightnessUp".spawn-sh = "brightnessctl --class=backlight set +10%";
            "XF86MonBrightnessDown".spawn-sh = "brightnessctl --class=backlight set 10%-";

            "Mod+1".focus-workspace = 1;
            "Mod+2".focus-workspace = 2;
            "Mod+3".focus-workspace = 3;
            "Mod+4".focus-workspace = 4;
            "Mod+5".focus-workspace = 5;
            "Mod+6".focus-workspace = 6;
            "Mod+7".focus-workspace = 7;
            "Mod+8".focus-workspace = 8;
            "Mod+9".focus-workspace = 9;
            "Mod+Shift+1".move-column-to-workspace = 1;
            "Mod+Shift+2".move-column-to-workspace = 2;
            "Mod+Shift+3".move-column-to-workspace = 3;
            "Mod+Shift+4".move-column-to-workspace = 4;
            "Mod+Shift+5".move-column-to-workspace = 5;
            "Mod+Shift+6".move-column-to-workspace = 6;
            "Mod+Shift+7".move-column-to-workspace = 7;
            "Mod+Shift+8".move-column-to-workspace = 8;
            "Mod+Shift+9".move-column-to-workspace = 9;
          };
        };
      };
    };
}
