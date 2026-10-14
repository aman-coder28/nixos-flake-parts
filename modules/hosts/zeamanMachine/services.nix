{ inputs, ... }: {
  flake.nixosModules.Services = { pkgs, ... }: {
    services.desktopManager.gnome.enable = true;
    services.displayManager.noctalia-greeter = {
      enable = true;
      settings = {
        cursor = {
          theme = "macOS";
          size = 28;
          path = pkgs.apple-cursor;
        };
      };
    };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    programs.niri.enable = true;

    services.clamav = {
      daemon.enable = true;
      updater.enable = true;
      scanner.enable = true;
      # clamonacc.enable = true;
    };

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
