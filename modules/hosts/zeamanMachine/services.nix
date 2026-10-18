{ ... }: {
  flake.nixosModules.Services = { pkgs, ... }: {
    services.desktopManager.gnome.enable = true;

    services.displayManager.noctalia-greeter = {
      enable = true;
      settings = {
        cursor.size = 30;
        keyboard.layout = "us";
      };
      cursorTheme = {
        package = pkgs.apple-cursor;
        name = "macOS";
      };
    };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    programs.niri.enable = true;
    programs.mango.enable = true;

    programs.nh = {
      enable = true;

      flake = "/home/zeamanuel/Code/config/nixos-flake-parts/";
    };

    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        settings.main = {
          leftalt = "rightcontrol";
          leftcontrol = "rightcontrol";
          leftshift = "shift";
          capslock = "overload(shift)";
        };
      };
    };

    environment.etc."libinput/local-overrides.quirks".text = ''
      [Serial Keyboards]
      MatchUdevType=keyboard
      MatchName=keyd virtual keyboard
      AttrKeyboardIntegration=internal
    '';

    services.flatpak.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    services.power-profiles-daemon.enable = true;
    services.thermald.enable = true;
    powerManagement = {
      enable = true;
      powertop.enable = true;
    };
    services.upower.enable = true;
    hardware.bluetooth.enable = true;
  };
}
