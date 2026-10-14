{ inputs, ... }: {

  flake.nixosModules.Services = { pkgs, ... }: {
    services.displayManager.gdm = {
      enable = true;
    };
    services.desktopManager.gnome.enable = true;

    # programs.noctalia-greeter = {
    #   enable = true;
    #   package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;

    #   settings.cursor = {
    #     theme = "macOS";
    #     size = 24;
    #     package = pkgs.apple-cursor;
    #   };
    # };

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
